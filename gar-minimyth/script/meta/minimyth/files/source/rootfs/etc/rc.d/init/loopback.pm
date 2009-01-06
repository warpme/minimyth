#!/usr/bin/perl
################################################################################
# loopback
################################################################################
package init::loopback;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting loopback network interface ...");

    # Bring up the loopback network interface.
    system(qq(/sbin/ifconfig lo 127.0.0.1 up));

    # Start portmap on the local netowrk interface.
    system(qq(/sbin/portmap -l));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "stopping loopback network interface ...");

    # Stop portmap on the local network interface.
    $minimyth->application_stop('portmap');

    # Bring down the loopback network interface.
    system(qq(/sbin/ifconfig lo 0 down));

    return 1;
}

1;
