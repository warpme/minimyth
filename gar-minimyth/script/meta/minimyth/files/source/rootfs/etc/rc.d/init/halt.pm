#!/usr/bin/perl
################################################################################
# halt
################################################################################
package init::halt;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # halt.
    if (-f '/halt')
    {
        $minimyth->message_output('info', "halting system ...");
        system(qq(/sbin/halt -i));
    }
    # poweroff.
    else
    {
        $minimyth->message_output('info', "powering off system ...");
        system(qq(/sbin/halt -i -p));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return $self->start($minimyth);
}

1;
