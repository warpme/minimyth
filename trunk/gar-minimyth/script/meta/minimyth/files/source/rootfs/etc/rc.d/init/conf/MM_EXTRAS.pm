################################################################################
# MM_EXTRAS configuration variable handlers.
################################################################################
package init::conf::MM_EXTRAS;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_EXTRAS_URL'} =
{
    value_default  => 'auto',
    value_valid    => 'auto|none|((cifs|confro|confrw|dist|file|http|hunt|nfs|tftp):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_obsolete => 'default',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;
  
        if ($minimyth->var_get('MM_ROOTFS_TYPE') eq 'squashfs')
        {
            return "hunt:extras.sfs"
        }
        else
        {
            return "confro:extras.sfs"
        }
    },
    value_none     => ''
};

1;
