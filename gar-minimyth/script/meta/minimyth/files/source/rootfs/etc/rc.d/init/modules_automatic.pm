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

    # Loopback device.
    system(qq(/sbin/modprobe loop));

    # Net.
    system(qq(/sbin/modprobe af_packet));

    # Parallel port.
    system(qq(/sbin/modprobe parport));
    system(qq(/sbin/modprobe parport_pc));
    system(qq(/sbin/modprobe ppdev));

    # Enable modeprobe udev rules.
    rename('/usr/lib/udev/rules.d/01-minimyth-modprobe.rules.disabled', '/usr/lib/udev/rules.d/01-minimyth-modprobe.rules');

    # Trigger udev with the additional udev rules that handle detected hardware.
    system(qq(/sbin/udevadm trigger --action=add));
    system(qq(/sbin/udevadm settle --timeout=60));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
