#!/usr/bin/perl
################################################################################
# splash
################################################################################
package init::splash;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting splash screen ...");

    $minimyth->splash_init();

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "stopping splash screen ...");

    $minimyth->splash_halt();

    return 1;
}

1;
