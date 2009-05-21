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
            $device = $minimyth->device_canonicalize($device);
            $minimyth->var_set('MM_LCDPROC_DRIVER', $driver);
            $minimyth->var_set('MM_LCDPROC_DEVICE', $device);
        }

        return 1;
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
    value_none     => '',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $device = $minimyth->var_get($name);
        if (($device) && (! -e $device))
        {
            $minimyth->message_output('err', "LCD/VFD device '$device' specified by '$name' does not exist.");
            return 0;
        }

        return 1;
    }
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
$var_list{'MM_LCDPROC_KERNEL_MODULE_LIST'} =
{
    prerequisite   => ['MM_LCDPROC_KERNEL_MODULE', 'MM_LCDPROC_KERNEL_MODULE_OPTIONS'],
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

        return $minimyth->var_get('MM_LCDPROC_KERNEL_MODULE');
    },
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        # Create a modprobe configuration file with the LCDproc kernel module options.
        my $kernel_module         = $minimyth->var_get('MM_LCDPROC_KERNEL_MODULE');
        my $kernel_module_options = $minimyth->var_get('MM_LCDPROC_KERNEL_MODULE_OPTIONS');
        if (($kernel_module) && ($kernel_module_options))
        {
            my $modprobe_file = "/etc/modprobe.d/init::conf::MM_LCDPROC.conf";
            if ((open(FILE, '>', $modprobe_file)))
            {
                print FILE "# autogenerated by init::conf::MM_LCDPROC\n";
                print FILE "options $kernel_module $kernel_module_options\n";
            }
            else
            {
                return 0;
            }
        }
        return 1;
    }
};

1;
