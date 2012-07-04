################################################################################
# cpu
################################################################################
package init::cpu;

use strict;
use warnings;

use File::Spec ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $devnull = File::Spec->devnull;

    $minimyth->message_output('info', "starting CPU frequency scaling ...");

    if ($minimyth->var_get('MM_CPU_FREQUENCY_GOVERNOR') ne 'performance')
    {
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
