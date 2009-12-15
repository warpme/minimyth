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

    my $device = undef;
    my $driver = undef;

    my @device_list = split(/ +/, $minimyth->var_get('MM_LIRC_DEVICE_LIST'));
    foreach my $device_item (@device_list)
    {
        ($device, $driver, undef) = split(/,/, $device_item);
        if ($driver eq 'bdremote')
        {
            last;
        }
    }
    if ($driver eq 'bdremote')
    {
        $minimyth->message_output('info', "starting Sony PS3 Blu-ray Disc Remote Control daemon ...");

        my $daemon = '/usr/sbin/bdremoteng';
        $daemon = $daemon . " -l";
        $daemon = $daemon . " -E";
        $daemon = $daemon . " -a $device";
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

    $minimyth->application_stop('bdremoteng', "starting Sony PS3 Blu-ray Disc Remote Control daemon ...");

    return 1;
}

1;
