################################################################################
# MM_HARDWARE configuration variable handlers.
################################################################################
package init::conf::MM_HARDWARE;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_HARDWARE_KERNEL_MODULE_LIST'} =
{
    prerequisite   => ['MM_CPU_KERNEL_MODULE_LIST', 'MM_LCDPROC_KERNEL_MODULE_LIST', 'MM_LIRC_KERNEL_MODULE_LIST', 'MM_PLUGIN_KERNEL_MODULE_LIST', 'MM_WIIMOTE_KERNEL_MODULE_LIST', 'MM_X_KERNEL_MODULE_LIST'],
    value_default  => '',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @kernel_modules = split(/ +/, $minimyth->var_get($name));

        foreach my $delta_name ('CPU', 'LCDPROC', 'LIRC', 'PLUGIN', 'WIIMOTE', 'X')
        {
            my $delta_kernel_modules = $minimyth->var_get('MM_' . $delta_name . '_KERNEL_MODULE_LIST');
            if ($delta_kernel_modules)
            {
                push(@kernel_modules, split(/ +/, $delta_kernel_modules));
            }
        }

        # Remove any duplicates.
        {
            my $prev = '';
            @kernel_modules = grep($_ ne $prev && (($prev) = $_), sort(@kernel_modules));
        }

        $minimyth->var_set($name, join(' ', @kernel_modules));

        return 1;
    }
};

1;
