################################################################################
# MM_FLASH configuration variable handlers.
################################################################################
package init::conf::MM_FLASH;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_FLASH_URL'} =
{
    prerequisite   => ['MM_PLUGIN_BROWSER_ENABLED','MM_VERSION_MYTH_BINARY_MAJOR','MM_VERSION_MYTH_BINARY_MINOR'],
    value_default  => 'auto',
    value_valid    => 'auto|none|((cifs|confro|confrw|dist|file|http|hunt|nfs|tftp):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = 'none';

        if ( ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MAJOR') >  0) ||
             ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MINOR') > 21) )
        {
            if ($minimyth->var_get('MM_PLUGIN_BROWSER_ENABLED') eq 'yes')
            {
                if (-e '/lib/ld-linux.so.2')
                {
                    $value_auto = 'confrw:libflashplayer.32.so';
                }
            }
        }

        return $value_auto;
    },
    value_none     => ''
};

1;
