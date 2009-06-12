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
$var_list{'MM_WIIMOTE_EVENT_DEVICE_LIST'} =
{
    prerequisite   => ['MM_WIIMOTE_ADDRESS_0', 'MM_WIIMOTE_ADDRESS_1', 'MM_WIIMOTE_ADDRESS_2', 'MM_WIIMOTE_ADDRESS_3'],
    value_default  => 'auto',
    value_auto     => sub
    { 
 
        my $minimyth = shift;
        my $name     = shift;

        my @device_list;

        foreach my $wiimote ('0', '1', '2', '3')
        {
            my $address = $minimyth->var_get('MM_WIIMOTE_ADDRESS_' . $wiimote);
            if ($address)
            {
                my $device = qq(/dev/persistent/event-wminput:$address);
                push(@device_list, $device);
            }
        }

        return join(' ', @device_list);
    }
};
$var_list{'MM_WIIMOTE_KERNEL_MODULE_LIST'} =
{
    prerequisite   => ['MM_WIIMOTE_EVENT_DEVICE_LIST'],
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

        if ($minimyth->var_get('MM_WIIMOTE_EVENT_DEVICE_LIST'))
        {
            push(@kernel_modules, 'uinput');
        }

        return join(' ', @kernel_modules);
    }
};

1;
