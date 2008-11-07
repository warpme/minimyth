#!/usr/bin/perl
################################################################################
# MM_WIIMOTE configuration variable handlers.
################################################################################
package init::conf::MM_WIIMOTE;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_WIIMOTE_ENABLED'} =
{
    prerequisite   => ['MM_WIIMOTE_ADDRESS_0', 'MM_WIIMOTE_ADDRESS_1', 'MM_WIIMOTE_ADDRESS_2', 'MM_WIIMOTE_ADDRESS_3'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (($minimyth->var_get('MM_WIIMOTE_ADDRESS_0')) ||
            ($minimyth->var_get('MM_WIIMOTE_ADDRESS_1')) ||
            ($minimyth->var_get('MM_WIIMOTE_ADDRESS_2')) ||
            ($minimyth->var_get('MM_WIIMOTE_ADDRESS_3')))
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (($minimyth->var_get('MM_WIIMOTE_ADDRESS_0')) ||
            ($minimyth->var_get('MM_WIIMOTE_ADDRESS_1')) ||
            ($minimyth->var_get('MM_WIIMOTE_ADDRESS_2')) ||
            ($minimyth->var_get('MM_WIIMOTE_ADDRESS_3')))
        {
            return 'yes';
        }
        else
        {
            return 'no|yes';
        }
    }
};
$var_list{'MM_WIIMOTE_ADDRESS_0'} =
{
    value_default  => ''
};
$var_list{'MM_WIIMOTE_ADDRESS_1'} =
{
    value_default  => ''
};
$var_list{'MM_WIIMOTE_ADDRESS_2'} =
{
    value_default  => ''
};
$var_list{'MM_WIIMOTE_ADDRESS_3'} =
{
    value_default  => ''
};

1;
