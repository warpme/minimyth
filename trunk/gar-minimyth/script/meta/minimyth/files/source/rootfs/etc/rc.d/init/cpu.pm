#!/usr/bin/perl
################################################################################
# cpu
################################################################################
package init::cpu;

use strict;
use warnings;

require File::Spec;
require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $devnull = File::Spec->devnull;

    if ($minimyth->var_get('MM_CPU_FETCH_MICROCODE_DAT') eq 'yes')
    {
        $minimyth->message_output('info', "loading CPU microcode ...");

        if (! -e '/etc/firmware/microcode.dat')
        {
            $minimyth->message_output('err', "error: '/etc/firmware/microcode.dat' does not exist.");
            return 0;
        }

        my $kernel_module = 'microcode';
        if (system(qq(/sbin/modprobe $kernel_module > $devnull 2>&1)) != 0)
        {
            $minimyth->message_output('err', "error: failed to load kernel module: $kernel_module");
            return 0;
        }
        system(qq(/sbin/udevadm settle --timeout=60));
        if (! -e '/dev/cpu/microcode')
        {
            $minimyth->message_output('err', "error: '/dev/cpu/microcode' does not exist.");
            return 0;
        }
        if (! -e '/usr/sbin/microcode_ctl')
        {
            $minimyth->message_output('err', "error: '/usr/sbin/microcode_ctl' does not exist.");
            return 0;
        }
        if (system(qq(/usr/sbin/microcode_ctl -Q -f /etc/firmware/microcode.dat > $devnull 2>&1)) != 0)
        {
            $minimyth->message_output('err', "error: failed to load CPU microcode.");
            return 0;
        }
        system(qq(/sbin/modprobe -r $kernel_module));
    }

    $minimyth->message_output('info', "starting CPU frequency scaling ...");

    if ($minimyth->var_get('MM_CPU_FREQUENCY_GOVERNOR') ne 'performance')
    {
        # Load CPU frequency scaling processor kernel modules.
        # Kernel modules that do not support the CPU should fail to load.
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
                    system(qq(/sbin/modprobe $1 > $devnull 2>&1));
                }
            }
            closedir(DIR);
        }

        # Load CPU frequency governor kernel module.
        my $kernel_module = 'cpufreq-' . $minimyth->var_get('MM_CPU_FREQUENCY_GOVERNOR');
        if (system(qq(/sbin/modprobe $kernel_module > $devnull 2>&1)) != 0)
        {
            $minimyth->message_output('err', "error: failed to load kernel module: $kernel_module");
            return 0;
        }
        # Wait for everything to settle.                                        
        system(qq(/sbin/udevadm settle --timeout=60));

        if ((-d '/sys/devices/system/cpu') &&
            (opendir(DIR, '/sys/devices/system/cpu')))
        {
            foreach (grep(/^cpu[0-9]+$/, (readdir(DIR))))
            {
                if ((-f "/sys/devices/system/cpu/$_/cpufreq/scaling_governor") &&
                    (open(FILE, '>', "/sys/devices/system/cpu/$_/cpufreq/scaling_governor")))
                {
                    print FILE $minimyth->var_get('MM_CPU_FREQUENCY_GOVERNOR') . "\n";
                    close(FILE);
                }
            }
            closedir(DIR);
        }

        if ($minimyth->var_get('MM_CPU_FREQUENCY_GOVERNOR') eq 'userspace')
        {
            system(qq(/usr/sbin/powernowd > $devnull 2>&1));
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "stopping CPU frequency scaling ...");

    $minimyth->application_stop('powernowd');

    if ((-d '/sys/devices/system/cpu') &&
        (opendir(DIR, '/sys/devices/system/cpu')))
    {
        foreach (grep(/^cpu[0-9]+$/, (readdir(DIR))))
        {
            if ((-f "/sys/devices/system/cpu/$_/cpufreq/scaling_governor") &&
                (open(FILE, '>', "/sys/devices/system/cpu/$_/cpufreq/scaling_governor")))
            {
                print FILE "performance" . "\n";
                close(FILE);
            }
        }
        closedir(DIR);
    }

    return 1;
}

1;
