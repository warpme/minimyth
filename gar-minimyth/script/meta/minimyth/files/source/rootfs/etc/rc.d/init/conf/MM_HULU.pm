################################################################################
# MM_HULU configuration variable handlers.
################################################################################
package init::conf::MM_HULU;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_HULU_URL'} =
{
    prerequisite   => ['MM_FLASH'],
    value_default  => 'auto',
    value_valid    => 'auto|none|((cifs|confro|confrw|dist|file|http|hunt|nfs|tftp):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = 'none';

        if ($minimyth->var_get('MM_FLASH_URL') ne 'none')
        {
            if (-e '/lib/ld-linux.so.2')
            {
                $value_auto = 'confrw:huludesktop.32';
            }
            if (-e '/lib/ld-linux-x86-64.so.2')
            {
                $value_auto = 'confrw:huludesktop.64';
            }
        }

        return $value_auto;
    },
    value_none     => ''
};

1;
