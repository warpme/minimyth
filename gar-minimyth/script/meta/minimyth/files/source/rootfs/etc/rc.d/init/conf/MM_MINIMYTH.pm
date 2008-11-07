#!/usr/bin/perl
################################################################################
# MM_MINIMYTH configuration variable handlers.
################################################################################
package init::conf::MM_MINIMYTH;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_MINIMYTH_UPDATE_URL'} =
{
    value_default  => 'http://minimyth.org/download/stable/latest/'
};
$var_list{'MM_MINIMYTH_FETCH_MINIMYTH_PM'} =
{
    value_default  => 'no'
};
$var_list{'MM_MINIMYTH_BOOT_URL'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if ($minimyth->var_get('MM_TFTP_BOOT_URL'))
        {
            return $minimyth->var_get('MM_TFTP_BOOT_URL');
        }
        else
        {
            return 'file:/minimyth/';
        }
    }
};

1;
