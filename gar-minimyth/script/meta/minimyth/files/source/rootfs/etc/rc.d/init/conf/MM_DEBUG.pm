################################################################################
# MM_DEBUG configuration variable handlers.
################################################################################
package init::conf::MM_DEBUG;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_DEBUG'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
};

1;
