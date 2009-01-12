################################################################################
# MM_ACPI configuration variable handlers.
################################################################################
package init::conf::MM_ACPI;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_ACPI_EVENT_BUTTON_POWER'} =
{
        value_default => 'off',
	value_valid   => 'off|sleep|none'
};

$var_list{'MM_ACPI_VIDEO_FLAGS'} =
{
        value_default => '0',
	value_valid   => '0|1|2|3'
};

1;
