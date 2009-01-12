################################################################################
# MM_CPU configuration variable handlers.
################################################################################
package init::conf::MM_CPU;

use strict;
use warnings;
use feature "switch";

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

1;
