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
    value_auto     => 'confrw:codecs.sfs',
    value_none     => ''
};

1;
