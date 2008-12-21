#!/usr/bin/perl
################################################################################
# MM_CODECS configuration variable handlers.
################################################################################
package init::conf::MM_CODECS;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_CODECS_URL'} =
{
    value_default  => 'auto',
    value_valid    => 'auto|none|((cifs|confro|confrw|dist|file|http|hunt|nfs|tftp):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_obsolete => 'default',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = q(none);

        if    (-e q(/lib/ld-linux.so.2))
        {
            $value_auto = q(confrw:codecs.32.sfs);
        }
        elsif (-e q(/lib/ld-linux-x86-64.so.2))
        {
            $value_auto = q(confrw:codecs.64.sfs);
        }

        return $value_auto;
    },
    value_none     => ''
};

1;
