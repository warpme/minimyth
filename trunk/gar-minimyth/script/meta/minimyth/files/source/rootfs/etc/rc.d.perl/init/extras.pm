#!/usr/bin/perl
################################################################################
# extras
#
# This script (downloads and) mounts the extras directory tree.
################################################################################
package init::extras;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_EXTRAS_URL'))
    {
        $minimyth->message_output('info', "installing extras ...");

        $minimyth->url_mount($minimyth->var_get('MM_EXTRAS_URL'), '@EXTRAS_ROOTDIR@');
        system(qq(/sbin/ldconfig));
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
