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

    if ($minimyth->var_get('MM_LIRC_DRIVER') eq 'iguanaIR')
    {
        $minimyth->message_output('info', "starting iguanaIR daemon ...");
        system('/usr/bin/igdaemon',
               '--log-file=/var/log/igdaemon.log',
               '--pid-file=/var/run/igdaemon.pid');
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
