################################################################################
# MM_CPU configuration variable handlers.
################################################################################
package init::conf::MM_CPU;

use strict;
use warnings;
use feature "switch";

use File::Spec ();

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_CPU_VENDOR'} =
{
    value_default  => 'auto',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = undef;
        if ((-r '/proc/cpuinfo') && open(FILE, '<', '/proc/cpuinfo'))
        {
            while (<FILE>)
            {
                chomp;
                if (/^vendor_id[[:cntrl:]]*: (.*)$/ )
                {
                    $value_auto = $1;
                    last;
                }
            }
            close(FILE);
        }
        return $value_auto;
    }
};
$var_list{'MM_CPU_FAMILY'} =
{
    value_default  => 'auto',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = undef;
        if ((-r '/proc/cpuinfo') && open(FILE, '<', '/proc/cpuinfo'))
        {
            while (<FILE>)
            {
                chomp;
                if (/^cpu family[[:cntrl:]]*: (.*)$/ )
                {
                    $value_auto = $1;
                    last;
                }
            }
            close(FILE);
        }
        return $value_auto;
    }
};
$var_list{'MM_CPU_MODEL'} =
{
    value_default  => 'auto',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = undef;
        if ((-r '/proc/cpuinfo') && open(FILE, '<', '/proc/cpuinfo'))
        {
            while (<FILE>)
            {
                chomp;
                if (/^model[[:cntrl:]]*: (.*)$/ )
                {
                    $value_auto = $1;
                    last;
                }
            }
            close(FILE);
        }
        return $value_auto;
    }
};
$var_list{'MM_CPU_FREQUENCY_GOVERNOR'} =
{
    value_default  => 'performance',
    value_valid    => 'conservative|ondemand|performance|powersave|userspace',
};
$var_list{'MM_CPU_FETCH_MICROCODE_DAT'} =
{
    prerequisite   => ['MM_CPU_VENDOR', 'MM_CPU_FAMILY'],
    value_default  => 'no',
    value_valid    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_valid;

        if (($minimyth->var_get('MM_CPU_VENDOR') eq 'GenuineIntel') &&
            ($minimyth->var_get('MM_CPU_FAMILY') >= 6             ))
        {
            $value_valid = 'no|yes';
        }
        else
        {
            $value_valid = 'no';
        }

        return $value_valid;
    },
    value_file     => 'yes',
    file           => {name_remote => '/microcode.dat',
                       name_local  => '/etc/firmware/microcode.dat'}
};
$var_list{'MM_CPU_KERNEL_MODULE_LIST'} =
{
    prerequisite   => [ 'MM_CPU_FAMILY', 'MM_CPU_MODEL', 'MM_CPU_VENDOR', 'MM_CPU_FREQUENCY_GOVERNOR' ],
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

        my @kernel_modules;

        my $devnull = File::Spec->devnull;

        my $vendor = $minimyth->var_get('MM_CPU_VENDOR');
        my $family = $minimyth->var_get('MM_CPU_FAMILY');
        my $model  = $minimyth->var_get('MM_CPU_MODEL');
        if ($vendor)
        {
            if ((-f  '/etc/hardware.d/cpu2kernel.map') && open(FILE, '<', '/etc/hardware.d/cpu2kernel.map'))
            {
                foreach (grep((! /^ *$/) && (! /^ *#/), (<FILE>)))
                {
                    chomp;
                    s/ +/ /g;
                    s/^ //;
                    s/ $//;
                    s/ ?, ?/,/g;
                    if (/^($vendor),([^,]*),([^,]*),([^,]*)$/)
                    {
                        if (((! $2) || ($2 eq $family)) &&
                            ((! $3) || ($3 eq $model )))
                        {
                            push(@kernel_modules, split(/ /, $4));
                        }
                    }
                }
            }
        }

        if ($minimyth->var_get('MM_CPU_FREQUENCY_GOVERNOR') ne 'performance')
        {
            my $kernel_version = '';
            if ((-d '/lib/modules') &&
                (opendir(DIR, '/lib/modules')))
            {
                foreach (grep(! /^\./, readdir(DIR)))
                {
                    $kernel_version = $_;
                    last;
                }
                closedir(DIR);
            }
            my $kernel_arch = '';
            if (($kernel_version) && 
                (-d "/lib/modules/$kernel_version/kernel/arch") &&
                (opendir(DIR, "/lib/modules/$kernel_version/kernel/arch")))
            {
                foreach (grep(! /^\./, readdir(DIR)))
                {
                    $kernel_arch = $_;
                    last;
                }
                closedir(DIR);
            }
            if (($kernel_version) && ($kernel_arch) &&
                (-d "/lib/modules/$kernel_version/kernel/arch/$kernel_arch/kernel/cpu/cpufreq") &&
                (opendir(DIR, "/lib/modules/$kernel_version/kernel/arch/$kernel_arch/kernel/cpu/cpufreq")))
            {
                foreach (grep(! /^\./, readdir(DIR)))
                {
                    if (/^(.*)\.ko$/)
                    {
                        # Kernel modules that do not support the CPU should fail to load.
                        if (system(qq(/sbin/modprobe $1 > $devnull 2>&1)) == 0)
                        {
                            system(qq(/sbin/modprobe -r $1 > $devnull 2>&1));
                            push(@kernel_modules, $1);
                        }
                    }
                }
                closedir(DIR);
            }

            # Add frequency governor kernel module.
            push(@kernel_modules, 'cpufreq-' . $minimyth->var_get('MM_CPU_FREQUENCY_GOVERNOR'));
        }

        return join(' ', @kernel_modules);
    }
};

1;
