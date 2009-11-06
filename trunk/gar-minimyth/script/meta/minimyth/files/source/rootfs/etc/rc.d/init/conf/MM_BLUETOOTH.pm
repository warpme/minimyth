################################################################################
# MM_BLUETOOTH configuration variable handlers.
################################################################################
package init::conf::MM_BLUETOOTH;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_BLUETOOTH_DEVICE_LIST'} =
{
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_auto     => sub
    {
        my @devices = ();
        if ((-e '/sys/class/bluetooth') && (opendir(DIR, '/sys/class/bluetooth')))
        {
            foreach (grep(! /\./, (readdir(DIR))))
            {
                
                push(@devices, $_);
            }
            closedir(DIR);
        }

        return join(' ', @devices);
    },
    value_none     => ''
};
$var_list{'MM_BLUETOOTH_KERNEL_MODULE_LIST'} =
{
    prerequisite   => ['MM_BLUETOOTH_DEVICE_LIST'],
    value_clean    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        $minimyth->var_set($name, 'auto');

        return 1;
    },
    value_default  => 'auto',
    value_valid    => 'auto',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @kernel_modules = ();

        if ($minimyth->var_get('MM_BLUETOOTH_DEVICE_LIST'))
        {
            push(@kernel_modules, 'uinput');
        }

        return join(' ', @kernel_modules);
    }
};

1;
