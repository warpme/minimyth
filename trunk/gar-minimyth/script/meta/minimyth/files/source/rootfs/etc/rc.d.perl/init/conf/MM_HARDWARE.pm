#!/usr/bin/perl
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

$var_list{'MM_HARDWARE_KERNEL_MODULES'} =
{
    prerequisite   => ['MM_CPU_VENDOR', 'MM_CPU_FAMILY', 'MM_CPU_MODEL', 'MM_X_DRIVER'],
    value_default  => '',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @kernel_modules = split(/  +/, $minimyth->var_get($name));

        # Get CPU related kernel modules.
        {
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
                        s/ ?, ?/,/;
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
        }

        # Get X related kernel modules.
        {
            my $x_driver = $minimyth->var_get('MM_X_DRIVER');
            if ($x_driver)
            {
                if ((-f  '/etc/hardware.d/x2kernel.map') && open(FILE, '<', '/etc/hardware.d/x2kernel.map'))
                {
                    foreach (grep((! /^ *$/) && (! /^ *#/), (<FILE>)))
                    {
                        chomp;
                        s/ +/ /g;
                        s/^ //;
                        s/ $//;
                        s/ ?, ?/,/;
                        if (/^($x_driver),([^,]*)$/)
                        {
                            push(@kernel_modules, split(/ /, $2));
                            last;
                        }
                    }
                }
            }
        }

        # Remove any dumplicates.
        {
            my $prev = '';
            @kernel_modules = grep($_ ne $prev && (($prev) = $_), sort(@kernel_modules));
        }

        $minimyth->var_set($name, join(' ', @kernel_modules));
    }
};

1;
