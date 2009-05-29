################################################################################
# iguanair
################################################################################
package init::iguanair;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $igdaemon_enabled = 'no';
    my @device_list = split(/ +/, $minimyth->var_get('MM_LIRC_DEVICE_LIST'));
    foreach my $device_item (@device_list)
    {
        my (undef, $driver, undef) = split(/,/, $device_item);
        if ($driver eq 'iguanaIR')
        {
            $igdaemon_enabled = 'yes';
        }
    }
    if ($igdaemon_enabled eq 'yes')
    {
        $minimyth->message_output('info', "starting iguanaIR daemon ...");
        system('/usr/bin/igdaemon',
               '--log-file=/var/log/igdaemon.log',
               '--pid-file=/var/run/igdaemon.pid')
    }
    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('igdeamon', "stopping iguanaIR daemon ...");

    return 1;
}

1;
