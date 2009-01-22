################################################################################
# MM_LCDPROC configuration variable handlers.
################################################################################
package init::conf::MM_LCDPROC;

use strict;
use warnings;
use feature "switch";

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_LCDPROC_DRIVER'} =
{
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_none     => '',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if ($minimyth->var_get($name) eq 'auto')
        {
            my $driver = $minimyth->detect_state_get('lcdproc', 0, 'driver') || '';
            my $device = $minimyth->detect_state_get('lcdproc', 0, 'device') || '';
            $minimyth->var_set('MM_LCDPROC_DRIVER', $driver);
            $minimyth->var_set('MM_LCDPROC_DEVICE', $device);
        }
    }
};
$var_list{'MM_LCDPROC_DEVICE'} =
{
    prerequisite   => ['MM_LCDPROC_DRIVER'],
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $auto = '';
       
        my $driver = $minimyth->var_get('MM_LCDPROC_DRIVER');
        if ($driver)
        {
            my $driver_file = "/etc/lcdproc.d/driver.conf.d/driver.conf.$driver";
            if ((-r $driver_file) && (open(FILE, '<', $driver_file)))
            {
                while (<FILE>)
                {
                    chomp;
                    /^$name='([^']*)'$/ && do { $auto = $1; };
                }
                close(FILE);
            }
        }
        return $auto;
    },
    value_none     => ''
};
$var_list{'MM_LCDPROC_KERNEL_MODULE'} =
{
    prerequisite   => ['MM_LCDPROC_DRIVER'],
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $auto = '';
       
        my $driver = $minimyth->var_get('MM_LCDPROC_DRIVER');
        if ($driver)
        {
            my $driver_file = "/etc/lcdproc.d/driver.conf.d/driver.conf.$driver";
            if ((-r $driver_file) && (open(FILE, '<', $driver_file)))
            {
                while (<FILE>)
                {
                    chomp;
                    /^$name='([^']*)'$/ && do { $auto = $1; };
                }
                close(FILE);
            }
        }
        return $auto;
    },
    value_none     => ''
};
$var_list{'MM_LCDPROC_KERNEL_MODULE_OPTIONS'} =
{
    prerequisite   => ['MM_LCDPROC_DRIVER'],
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $auto = '';
       
        my $driver = $minimyth->var_get('MM_LCDPROC_DRIVER');
        if ($driver)
        {
            my $driver_file = "/etc/lcdproc.d/driver.conf.d/driver.conf.$driver";
            if ((-r $driver_file) && (open(FILE, '<', $driver_file)))
            {
                while (<FILE>)
                {
                    chomp;
                    /^$name='([^']*)'$/ && do { $auto = $1; };
                }
                close(FILE);
            }
        }
        return $auto;
    },
    value_none     => ''
};
$var_list{'MM_LCDPROC_FETCH_LCDD_CONF'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {'name_remote' => '/LCDd.conf',
                       'name_local'  => '/etc/LCDd.conf'}
};

1;
