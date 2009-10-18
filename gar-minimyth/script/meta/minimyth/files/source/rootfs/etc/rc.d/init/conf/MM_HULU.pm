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
    prerequisite   => ['MM_FLASH_URL'],
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

$var_list{'MM_HULU_REMOTE'} =
{
    value_default => 'mceusb',
    value_valid   => '.+',
    value_none    => ''
};

$var_list{'MM_HULU_STORE_HULUDESKTOP_DATA'} =
{
    prerequisite   => ['MM_HULU_URL'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_default = 'no';

        if ($minimyth->var_get('MM_HULU_URL') ne '')
        {
            $value_default = 'yes';
        }

        if (-e '/usr/bin/huludesktop')
        {
            $value_default = 'yes';
        }

        return $value_default;
    },
    value_valid    => 'no|yes'
};

1;
