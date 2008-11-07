#!/usr/bin/perl
################################################################################
# codecs
################################################################################
package init::codecs;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_CODECS_URL'))
    {
        $minimyth->message_output('info', "installing binary codecs ...");
        $minimyth->url_mount($minimyth->var_get('MM_CODECS_URL'), '/usr/lib/codecs');
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
