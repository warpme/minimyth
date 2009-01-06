#!/usr/bin/perl
################################################################################
# sensors
################################################################################
package init::sensors;

use strict;
use warnings;

use File::Spec ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $devnull = File::Spec->devnull;

    $minimyth->message_output('info', "checking sensors ...");

    if (system(qq(/usr/bin/sensors > $devnull 2>&1)) != 0)
    {
       $minimyth->message_log('warn', "it is likely that the motherboard sensor chip was not detected.");
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
