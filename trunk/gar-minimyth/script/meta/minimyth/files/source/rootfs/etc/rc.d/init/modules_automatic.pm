################################################################################
# modules_automatic
################################################################################
package init::modules_automatic;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "loading kernel modules (automatic) ...");

    # Real time clock.
    system(qq(/sbin/modprobe rtc));

    # IO scheduler.
    system(qq(/sbin/modprobe as-iosched));

    # Loopback device.
    system(qq(/sbin/modprobe loop));

    # Net.
    system(qq(/sbin/modprobe af_packet));

    # Parallel port.
    system(qq(/sbin/modprobe parport));
    system(qq(/sbin/modprobe parport_pc));
    system(qq(/sbin/modprobe ppdev));

    # Enable modeprobe udev rules.
    rename('/lib/udev/rules.d/01-minimyth-modprobe.rules.disabled', '/lib/udev/rules.d/01-minimyth-modprobe.rules');

    # Trigger udev with the additional udev rules that handle detected hardware.
    system(qq(/sbin/udevadm trigger));
    system(qq(/sbin/udevadm settle --timeout=60));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "unloading kernel modules (automatic) ...");

    if (open(FILE, '-|', '/bin/lsmod'))
    {
        while (<FILE>)
        {
            chomp;
            if (/^([^ ]+)/)
            {
                system(qq(/sbin/modprobe -r $1));
            }
        }
    }

    return 1;
}

1;
