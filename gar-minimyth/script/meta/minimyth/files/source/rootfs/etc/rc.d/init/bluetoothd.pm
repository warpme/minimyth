################################################################################
# bluetoothd
################################################################################
package init::bluetoothd;

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
        $minimyth->message_output('info', "starting bluetooth daemon ...");

        if (-e '/usr/sbin/bluetoothd')
        {
            system(qq(/usr/sbin/bluetoothd));
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('bluetoothd', "stopping bluetooth daemon ...");

    return 1;
}

1;
