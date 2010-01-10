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

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # There are is no configured remote control device and we will not auto-detect any later, so there is no need to continue.
    if ( ($minimyth->var_get('MM_LIRC_DRIVER')       eq ''  ) &&
         ($minimyth->var_get('MM_LIRC_AUTO_ENABLED') eq 'no') )
    {
        return 1;
    }

    $minimyth->message_output('info', "starting remote control(s) ...");

    # Create directories used by the LIRC daemon.
    File::Path::mkpath('/var/lock', { mode => 0755 });
    chmod(0755, '/var/lock');
    File::Path::mkpath('/var/run/lirc', { mode => 0755 });
    chmod(0755, '/var/run/lirc');

    # If the driver is for an lircd supported device that cannot be detected by udev,
    # then start the lircd daemon for the device.
    my $driver = $minimyth->var_get('MM_LIRC_DRIVER');
    if ($driver =~ /^udp$/)
    {
        my $device = $minimyth->var_get('MM_LIRC_DEVICE');

        # Convert the driver to the lirc daemon appropriate driver.
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

        # Start the lircd daemon.
        my $instance = $device;
        $instance =~ s/\/+/~/g;
        $instance =~ s/^~dev~//;
        my $daemon = '/usr/sbin/lircd';
        $daemon = $daemon . " --driver=$driver";
        $daemon = $daemon . " --device=$device";
        $daemon = $daemon . " --output=/var/run/lirc/lircd-$instance --pidfile=/var/run/lirc/lircd-$instance.pid";
        $daemon = $daemon . " --uinput";
        $daemon = $daemon . " /etc/lirc/lircd.conf";

        $minimyth->message_log('info', "started '$daemon'.");
        system(qq($daemon));
    }

    # Start the eventlircd daemon.
    system(qq(/usr/sbin/eventlircd --evmap=/etc/eventlircd.d --socket=/var/run/lirc/lircd --release=:UP));

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
         ($minimyth->application_running('eventlircd')) ||
         ($minimyth->application_running('lircd')) ||
         ($minimyth->application_running('bdremoteng')) )
    {
        $minimyth->message_output('info', "stopping remote control ...");

        $minimyth->application_stop('lircmd');
        $minimyth->application_stop('irexec');
        $minimyth->application_stop('eventlircd');
        $minimyth->application_stop('lircd');
        $minimyth->application_stop('bdremoteng');
    }

    return 1;
}

1;
