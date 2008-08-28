#!/usr/bin/perl
################################################################################
# acpi
################################################################################
package init::acpi;

use strict;
use warnings;
use feature "switch";

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ((-w '/proc/sys/kernel/acpi_video_flags') && (open(FILE, '>', '/proc/sys/kernel/acpi_video_flags')))
    {
        print FILE $minimyth->var_get('MM_ACPI_VIDEO_FLAGS') . "\n";
        close(FILE);
    }

    given ($minimyth->var_get('MM_ACPI_EVENT_BUTTON_POWER'))
    {
        when (/^off$/)
        {
            $minimyth->file_replace_variable(
                '/etc/acpi/events/power',
                { '@MM_ACPI_EVENT_BUTTON_POWER@' => '/sbin/poweroff'    });
        }
        when (/^sleep$/)
        {
            $minimyth->file_replace_variable(
                '/etc/acpi/events/power',
                { '@MM_ACPI_EVENT_BUTTON_POWER@' => '/usr/bin/mm_sleep' });
        }
    }
    
    $minimyth->message_output('info', "starting ACPI ...");

    system(qq(/usr/sbin/acpid));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if (qx(/bin/pidof acpid))
    {
        $minimyth->message_output('info', "stopping ACPI ...");
        system(qq(/usr/bin/killall acpid));
    }

    return 1;
}

1;
