################################################################################
# bdremote
################################################################################
package init::bdremote;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_LIRC_DRIVER') eq 'bdremote')
    {
        $minimyth->message_output('info', "starting Sony PS3 Blu-ray Disc Remote Control daemon ...");

        my $daemon = '/usr/sbin/bdremoteng';
        $daemon = $daemon . " -l";
        $daemon = $daemon . " -E";
        $daemon = $daemon . " -a " . $minimyth->var_get('MM_LIRC_DEVICE');
        $daemon = $daemon . " -t 30";
        $daemon = $daemon . " -p 8765";
        system(qq($daemon));
    }
    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('bdremoteng', "stopping Sony PS3 Blu-ray Disc Remote Control daemon ...");

    return 1;
}

1;
