################################################################################
# lirc
################################################################################
package init::lirc;

use strict;
use warnings;

use Cwd ();
use File::Basename ();
use File::Path ();
use MiniMyth ();

sub _remote_wakeup_enable
{
    my $self   = shift;
    my $device = shift;

    if (($device) && (-e $device) && (open(FILE, '-|', qq(/sbin/udevadm info --query=name --root --name='$device'))))
    {
        while (<FILE>)
        {
            chomp;
            $device = $_;
            last;
        }
        close(FILE);
    }

    if ((! -r '/sys/class/lirc') ||
        (! opendir(DIR, '/sys/class/lirc')))
    {
        return 1;
    }
    my @lirc_list = ();
    foreach (grep(! /^\./, (readdir(DIR))))
    {
        push(@lirc_list, $_);
    }
    closedir(DIR);
    
    foreach my $lirc (@lirc_list)
    {
        my $name = '';
        if (open(FILE, '-|', qq(/sbin/udevadm info --query=name --root --path='/sys/class/lirc/$lirc')))
        {
            while (<FILE>)
            {
                chomp;
                $name = $_;
                last;
            }
            close(FILE);
        }
        if ($name ne $device)
        {
            next;
        }

        my $devpath = Cwd::abs_path(qq(/sys/class/lirc/$lirc/device));
        $devpath = File::Basename::dirname($devpath);
        $devpath = File::Basename::dirname($devpath);

        if ((! -r "$devpath/busnum") || 
            (! open(FILE, '<', "$devpath/busnum")))
        {
            next;
        }
        my $busnum = undef;
        foreach (grep(/^[0-9]+$/,(<FILE>)))
        {
            chomp;
            $busnum = $_;
            last;
        }
        close(FILE);
        if (! defined($busnum))
        {
            next;
        }
    
        if ((! -r "$devpath/subsystem/devices/usb$busnum/serial") ||
            (! open(FILE, '<', "$devpath/subsystem/devices/usb$busnum/serial")))
        {
            next;
        }
        my $serial = undef;
        foreach (grep(! /^$/,(<FILE>)))
        {
            chomp;
            $serial = $_;
            last;
        }
        close(FILE);
        if (! defined($serial))
        {
            next;
        }

        if ((! -r '/proc/acpi/wakeup') ||
            (! open(FILE, '<', '/proc/acpi/wakeup')))
        {
            next;
        }
        my $entry = undef;
        foreach (grep(/$serial$/, (<FILE>)))
        {
            chomp;
            $entry = $_;
        }
        close(FILE);
        if (! defined($entry))
        {
            next;
        }

        my $device = (split(/ +/, $entry))[0];
        if ((! defined($device)) || ($device eq ''))
        {
            next;
        }

        my $status = (split(/ +/, $entry))[2];
        if ((! defined($status)) || ($status eq ''))
        {
            next;
        }
        
        if ($status ne 'enabled')
        {
            if ((! -w '/proc/acpi/wakeup') ||
                (! open(FILE, '>', '/proc/acpi/wakeup')))
            {
                next;
            }
            print FILE $device . "\n";
            close(FILE);
        }
    }

    return 1;
}

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my @device_list = split(/ +/, $minimyth->var_get('MM_LIRC_DEVICE_LIST'));

    # There are no remote control devices, so there is no need to continue.
    if (($#device_list + 1) <= 0)
    {
        return 1;
    }

    $minimyth->message_output('info', "starting remote control(s) ...");

    # Determine master LIRC daemon.
    # The master LIRC daemon combines the LIRC daemons for multiple LIRC devices.
    # Therefore, if there is more than one LIRC device, then we need a master LIRC daemon.
    my $daemon_master = '';
    if (($#device_list + 1) > 1)
    {
        $daemon_master = '/usr/sbin/lircd';
        $daemon_master = $daemon_master . ' --driver=null';
        $daemon_master = $daemon_master . ' --output=/var/run/lirc/lircd --pidfile=/var/run/lirc/lircd.pid';
        for (my $index = 0 ; $index <= $#device_list ; $index++)
        {
            my $port = 8765 + $index;
            $daemon_master = $daemon_master . " --connect=localhost:$port"
        }
    }

    # Create directories used by the LIRC daemon.
    File::Path::mkpath('/var/lock', { mode => 0755 });
    chmod(0755, '/var/lock');
    File::Path::mkpath('/var/run/lirc', { mode => 0755 });
    chmod(0755, '/var/run/lirc');

    # Enable wakeup and start an LIRC daemon for each device.
    my $index = 0;
    foreach my $device_item (@device_list)
    {
        my @device_args = split(/,/, $device_item);
        my $device     = $device_args[0];
        my $driver     = $device_args[1];
        my $lircd_conf = $device_args[2];

        # Convert driver to the the lirc daemon appropriate driver.
        if (($driver) && (open(FILE, '-|', '/usr/sbin/lircd --driver=help 2>&1')))
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

        # Start daemon.
        my $daemon = '';
        my $instance = $device;
        $instance =~ s/\/+/~/g;
        $instance =~ s/^~dev~//;
        if ($daemon_master)
        {
            my $port = 8765 + $index;
            $daemon = '/usr/sbin/lircd';
            $daemon = $daemon . " --device=$device --driver=$driver";
            $daemon = $daemon . " --output=/var/run/lirc/lircd-$instance --pidfile=/var/run/lirc/lircd-$instance.pid";
            $daemon = $daemon . " --listen=$port";
            $daemon = $daemon . " $lircd_conf";
        }
        else
        {
            $daemon = '/usr/sbin/lircd';
            $daemon = $daemon . " --device=$device --driver=$driver";
            $daemon = $daemon . ' --output=/var/run/lirc/lircd --pidfile=/var/run/lirc/lircd.pid';
            $daemon = $daemon . " $lircd_conf";
            symlink('/var/run/lirc/lircd', "/var/run/lirc/lircd-$instance");
        }
        $minimyth->message_log('info', "started '$daemon'.");
        system(qq($daemon));

        $index++;
    }

    # Start master LIRC daemon.
    if ($daemon_master)
    {
        system(qq($daemon_master));
    }

    # Start the irexec daemon.
    if ($minimyth->var_get('MM_LIRC_IREXEC_ENABLED') eq 'yes')
    {
        system(qq(/usr/bin/irexec -d /etc/lircrc));
    }

    # Start the lircmd daemon.
    if (-e '/etc/lircmd.conf')
    {
        system(qq(/usr/sbin/lircmd --uinput /etc/lircmd.conf));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if ( ($minimyth->application_running('lircmd')) ||
         ($minimyth->application_running('irexec')) ||
         ($minimyth->application_running('lircd')) )
    {
        $minimyth->message_output('info', "stopping remote control ...");

        $minimyth->application_stop('lircmd');
        $minimyth->application_stop('irexec');
        $minimyth->application_stop('lircd');
    }

    return 1;
}

1;
