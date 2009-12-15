################################################################################
# lirc
################################################################################
package init::lirc;

use strict;
use warnings;
use feature "switch";

use Cwd ();
use File::Basename ();
use File::Path ();
use MiniMyth ();

sub _remote_wakeup_enable
{
    my $self   = shift;
    my $device = shift;

    my $wakeup_node = undef;

    if (($device) && (-e $device) && (open(FILE, '-|', qq(/sbin/udevadm info --query=all --attribute-walk --name='$device'))))
    {
        my $kernels    = undef;
        my $subsystems = undef;
        my $class      = undef;
        my $in_record  = 0;
        while (<FILE>)
        {
            chomp;
            my $field = $_;
            if ($field =~ /^ *looking at parent device .*$/)
            {
                $kernels    = undef;
                $subsystems = undef;
                $class      = undef;
                $in_record  = 1;
                next;
            }
            if ($in_record)
            {
                if ($field =~ /^ *$/)
                {
                    if (($kernels =~ /^[^ ]+/) && ($subsystems =~ /^pci$/) && ($class =~ /^0x0c03(0|1|2)0$/))
                    {
                        $wakeup_node = "$subsystems:$kernels";
                        last;
                    }
                    $in_record  = 0;
                    next;
                }
                if ($field =~ /^ *([^ ]+)=="(.*)"$/)
                {
                    my $name  = $1;
                    my $value = $2;
                    given ($name)
                    {
                        when (/^KERNELS$/)
                        {
                            $kernels = $value;
                        }
                        when (/^SUBSYSTEMS$/)
                        {
                            $subsystems = $value;
                        }
                        when (/^ATTRS{class}$/)
                        {
                            $class = $value;
                        }
                    }
                    next;
                }
            }
        }
        close(FILE);
    }

    if ((defined($wakeup_node)) && ($wakeup_node ne ''))
    {
        if ((-r '/proc/acpi/wakeup') && (open(FILE, '<', '/proc/acpi/wakeup')))
        {
            my $wakeup_device = undef;
            my $wakeup_status = undef;
            foreach (grep(/ $wakeup_node$/, (<FILE>)))
            {
                chomp;
                ($wakeup_device, undef, $wakeup_status) = split(/ +/, $_);
                last;
            }
            close(FILE);

            if ((defined($wakeup_device)) && ($wakeup_device ne '') &&
                (defined($wakeup_status)) && ($wakeup_status ne '') &&
                ($wakeup_status ne 'enabled'))
            {
                if ((-w '/proc/acpi/wakeup') && (open(FILE, '>', '/proc/acpi/wakeup')))
                {
                    print FILE $wakeup_device . "\n";
                    close(FILE);
                }
            }
        }
    }

    return 1;
}

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my @device_list = split(/ +/, $minimyth->var_get('MM_LIRC_DEVICE_LIST'));

    # There are no remote control devices and we will not auto-detect any later, so there is no need to continue.
    if ((($#device_list + 1) <= 0) &&
        ($minimyth->var_get('MM_LIRC_AUTO_ENABLED') == 'no'))
    {
        return 1;
    }

    $minimyth->message_output('info', "starting remote control(s) ...");

    # Create directories used by the LIRC daemon.
    File::Path::mkpath('/var/lock', { mode => 0755 });
    chmod(0755, '/var/lock');
    File::Path::mkpath('/var/run/lirc', { mode => 0755 });
    chmod(0755, '/var/run/lirc');

    # Enable wakeup and start an LIRC daemon for each device.
    foreach my $device_item (@device_list)
    {
        my @device_args = split(/,/, $device_item);
        my $device     = $device_args[0];
        my $driver     = $device_args[1];
        my $lircd_conf = $device_args[2];

        if ((! $device) || (! $driver))
        {
            next;
        }

        # Convert the driver to the lirc daemon appropriate driver.
        if    (($driver) && ($driver =~ /^bdremote$/))
        {
        }
        elsif (($driver) && ($driver =~ /^irtrans$/))
        {
        }
        elsif (($driver) && (open(FILE, '-|', '/usr/sbin/lircd --driver=help 2>&1')))
        {
            my $driver_actual = 'default';
            while (<FILE>)
            {
	        chomp;
                s/[[:cntrl:]]//g;
                if (/^$driver$/)
                {
                    $driver_actual = $_;
                }
            }
            $driver = $driver_actual;
        }

        # Enable wakeup on remote.
        if ($minimyth->var_get('MM_LIRC_WAKEUP_ENABLED') eq 'yes')
        {
            $self->_remote_wakeup_enable($device);
        }

        # Start an lircd instance associated with the device the device is
        # handled by a unless a daemon other than lircd.
        if ( ($driver !~ /^bdremote$/) &&
             ($driver !~ /^irtrans$/ ) )
        {
            my $instance = $device;
            $instance =~ s/\/+/~/g;
            $instance =~ s/^~dev~//;
            my $daemon = '/usr/sbin/lircd';
            $daemon = $daemon . " --driver=$driver";
            $daemon = $daemon . " --device=$device";
            $daemon = $daemon . " --output=/var/run/lirc/lircd-$instance --pidfile=/var/run/lirc/lircd-$instance.pid";
            $daemon = $daemon . " --uinput";
            $daemon = $daemon . " $lircd_conf";
            $minimyth->message_log('info', "started '$daemon'.");
            system(qq($daemon));
        }
    }

    # Start the lircudevd daemon.
    system(qq(/usr/sbin/lircudevd --keymap=/etc/lircudevd.d --socket=/var/run/lirc/lircd --release=:UP));

    # Start the irexec daemon.
    if ($minimyth->var_get('MM_LIRC_IREXEC_ENABLED') eq 'yes')
    {
        system(qq(/usr/bin/irexec -d /etc/lirc/lircrc));
    }

    # Start the lircmd daemon.
    if (-e '/etc/lirc/lircmd.conf')
    {
        system(qq(/usr/sbin/lircmd --uinput /etc/lirc/lircmd.conf));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if ( ($minimyth->application_running('lircmd')) ||
         ($minimyth->application_running('irexec')) ||
         ($minimyth->application_running('lircudevd')) ||
         ($minimyth->application_running('lircd')) ||
         ($minimyth->application_running('bdremoteng')) )
    {
        $minimyth->message_output('info', "stopping remote control ...");

        $minimyth->application_stop('lircmd');
        $minimyth->application_stop('irexec');
        $minimyth->application_stop('lircudevd');
        $minimyth->application_stop('lircd');
        $minimyth->application_stop('bdremoteng');
    }

    return 1;
}

1;
