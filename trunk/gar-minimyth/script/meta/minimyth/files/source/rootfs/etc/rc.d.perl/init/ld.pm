#!/usr/bin/perl
################################################################################
# ld
################################################################################
package init::ld;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "configuring shared libraries ...");

    system(qq(/sbin/ldconfig));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
