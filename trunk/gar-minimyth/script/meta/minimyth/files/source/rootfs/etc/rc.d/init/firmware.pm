################################################################################
# firmware
################################################################################
package init::firmware;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if (-e q(/lib/firmware))
    {
        $minimyth->message_output('info', "loading kernel module firmware ...");

        # Enable firmware loading udev rules.
        rename('/lib/udev/rules.d/06-minimyth-firmware.rules.disabled', '/lib/udev/rules.d/06-minimyth-firmware.rules');

        # Trigger udev with the additional udev rules that handle firmware loading.
        system(qq(/sbin/udevadm trigger));
        system(qq(/sbin/udevadm settle --timeout=60));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
