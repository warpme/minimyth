################################################################################
# aquosserver
################################################################################
package init::aquosserver;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_EXTERNAL_AQUOS_ENABLED') eq 'yes')
    {
        $minimyth->message_output('info', "starting Sharp Aquos server...");
        my $device = $minimyth->var_get('MM_EXTERNAL_AQUOS_DEVICE');
        my $port   = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
        system("/usr/sbin/aquosserver serialport_device=$device listenport=$port 2>&1 | /usr/bin/logger -t aquosserver -p local0.info &");
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop("aquosserver", "stopping Sharp Aquos server ...");

    return 1;
}

1;
