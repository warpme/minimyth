#!/usr/bin/perl
################################################################################
# telnet
################################################################################
package init::telnet;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # Run telnet server on machines that have security disabled.
    if ($minimyth->var_get('MM_SECURITY_ENABLED') eq 'no')
    {
        if (! $minimyth->application_running('telnetd'))
        {
            $minimyth->message_output('info', "starting telnet server ...");
            system(qq(/usr/sbin/telnetd));
        }
    }
    # Otherwise, stop the telnet server.
    else
    {
        $self->stop($minimyth);
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('telnetd', "stopping telnet server ...");

    return 1;
}

1;
