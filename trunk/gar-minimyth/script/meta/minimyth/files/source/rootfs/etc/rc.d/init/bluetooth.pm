################################################################################
# bluetooth
################################################################################
package init::bluetooth;

use strict;
use warnings;

use File::Spec ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_BLUETOOTH_DEVICE_LIST'))
    {
        $minimyth->message_output('info', "starting bluetooth ...");

        my $devnull = File::Spec->devnull;

        my @devices = split(/ +/, $minimyth->var_get('MM_BLUETOOTH_DEVICE_LIST'));

        foreach my $device (@devices)
        {
            if (system(qq(/usr/sbin/hciconfig $device up > $devnull 2>&1)) != 0)
            {
                $minimyth->message_output('err', "configuration of bluetooth device '$device' failed (hciconfig command: up).");
                return 0;
            }
            if (system(qq(/usr/sbin/hciconfig $device lm master > $devnull 2>&1)) != 0)
            {
                $minimyth->message_output('err', "configuration of bluetooth device '$device' failed (hciconfig command: lm master).");
                return 0;
            }
        }
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
