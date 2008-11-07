#!/usr/bin/perl
################################################################################
# reboot
################################################################################
package init::reboot;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "rebooting system ...");
    system(qq(/sbin/reboot -i));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return $self->start($minimyth);
}

1;
