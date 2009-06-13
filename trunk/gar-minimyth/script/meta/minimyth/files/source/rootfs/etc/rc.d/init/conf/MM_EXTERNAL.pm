################################################################################
# MM_EXTERNAL configuration variable handlers.
################################################################################
package init::conf::MM_EXTERNAL;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_EXTERNAL_POWER_OFF'} =
{
    prerequisite   => ['MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_AQUOS_POWER_ENABLED'],
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        my @command_list = ();
        if ($minimyth->var_get($name))
        {
            push(@command_list, minimyth->var_get($name));
        }
        if ($minimyth->var_get('MM_EXTERNAL_AQUOS_POWER_ENABLED') eq 'yes')
        {
            my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
            push(@command_list, qq(/bin/echo -e "POWER OFF\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1));
        }
        if ($#command_list >= 0)
        {
            unlink('/usr/bin/mm_external_power_off');

            if (open(FILE, '>', '/usr/bin/mm_external_power_off'))
            {
                chmod(0755, '/usr/bin/mm_external_power_off');
                print FILE qq(#!/bin/sh\n);
                foreach my $command (@command_list)
                {
                    print FILE qq($command\n);
                }
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_POWER_OFF could not write '/usr/bin/mm_external_power_off'.");
                $success = 0;
            }
        }

        return $success;
    }
};
$var_list{'MM_EXTERNAL_POWER_ON'} =
{
    prerequisite   => ['MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_AQUOS_POWER_ENABLED', 'MM_EXTERNAL_AQUOS_INPUT'],
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        my @command_list = ();
        if ($minimyth->var_get($name))
        {
            push(@command_list, minimyth->var_get($name));
        }
        if ($minimyth->var_get('MM_EXTERNAL_AQUOS_POWER_ENABLED') eq 'yes')
        {
            my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
            push(@command_list, qq(/bin/echo -e "POWER ON\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1));
        }
        if ($minimyth->var_get('MM_EXTERNAL_AQUOS_INPUT'))
        {
            my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
            my $input = $minimyth->var_get('MM_EXTERANAL_AQUOS_INPUT');
            push(@command_list, qq(while /usr/bin/test `/bin/echo -e "CMD IAVD $input\\nEXIT" | /usr/bin/nc localhost $port 2> /dev/null` = 'ERR' ; do));
            push(@command_list, qq(    :));
            push(@command_list, qq(done));
        }
        if ($#command_list >= 0)
        {
            unlink('/usr/bin/mm_external_power_on');

            if (open(FILE, '>', '/usr/bin/mm_external_power_on'))
            {
                chmod(0755, '/usr/bin/mm_external_power_on');
                print FILE qq(#!/bin/sh\n);
                foreach my $command (@command_list)
                {
                    print FILE qq($command\n);
                }
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_POWER_ON could not write '/usr/bin/mm_external_power_on'.");
                $success = 0;
            }
        }

        return $success;
    }
};
$var_list{'MM_EXTERNAL_VOLUME_DOWN'} =
{
    prerequisite   => ['MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_AQUOS_VOLUME_ENABLED'],
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        my @command_list = ();
        if ($minimyth->var_get($name))
        {
            push(@command_list, minimyth->var_get($name));
        }
        if ($minimyth->var_get('MM_EXTERNAL_AQUOS_VOLUME_ENABLED') eq 'yes')
        {
            my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
            push(@command_list, qq(/bin/echo -e "VOL -\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1));
        }
        if ($#command_list >= 0)
        {
            unlink('/usr/bin/mm_external_volume_down');

            if (open(FILE, '>', '/usr/bin/mm_external_volume_down'))
            {
                chmod(0755, '/usr/bin/mm_external_volume_down');
                print FILE qq(#!/bin/sh\n);
                foreach my $command (@command_list)
                {
                    print FILE qq($command\n);
                }
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_DOWN could not write '/usr/bin/mm_external_volume_down'.");
                $success = 0;
            }
        }

        return $success;
    }
};
$var_list{'MM_EXTERNAL_VOLUME_UP'} =
{
    prerequisite   => ['MM_EXTERNAL_VOLUME_DOWN', 'MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_AQUOS_VOLUME_ENABLED'],
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        if ((  $minimyth->var_get('MM_EXTERNAL_VOLUME_UP')) && (! $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_UP is set but MM_EXTERNAL_VOLUME_DOWN is not set.");
            $success = 0;
        }
        if ((! $minimyth->var_get('MM_EXTERNAL_VOLUME_UP')) && (  $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_UP is not set but MM_EXTERNAL_VOLUME_DOWN is set.");
            $success = 0;
        }

        my @command_list = ();
        if ($minimyth->var_get($name))
        {
            push(@command_list, minimyth->var_get($name));
        }
        if ($minimyth->var_get('MM_EXTERNAL_AQUOS_VOLUME_ENABLED') eq 'yes')
        {
            my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
            push(@command_list, qq(/bin/echo -e "VOL +\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1));
        }
        if ($#command_list >= 0)
        {
            unlink('/usr/bin/mm_external_volume_up');

            if (open(FILE, '>', '/usr/bin/mm_external_volume_up'))
            {
                chmod(0755, '/usr/bin/mm_external_volume_up');
                print FILE qq(#!/bin/sh\n);
                foreach my $command (@command_list)
                {
                    print FILE qq($command\n);
                }
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_UP could not write '/usr/bin/mm_external_volume_up'.");
                $success = 0;
            }
        }

        return $success;
    }
};
$var_list{'MM_EXTERNAL_VOLUME_MUTE'} =
{
    prerequisite   => ['MM_EXTERNAL_VOLUME_DOWN', 'MM_EXTERNAL_VOLUME_UP', 'MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_AQUOS_VOLUME_ENABLED'],
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        if ((  $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (! $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is set but MM_EXTERNAL_VOLUME_DOWN is not set.");
            $success = 0;
        }
        if ((  $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (! $minimyth->var_get('MM_EXTERNAL_VOLUME_UP'  )))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is set but MM_EXTERNAL_VOLUME_UP is not set.");
            $success = 0;
        }
        if ((! $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (  $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is not set but MM_EXTERNAL_VOLUME_DOWN is set.");
            $success = 0;
        }
        if ((! $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (  $minimyth->var_get('MM_EXTERNAL_VOLUME_UP'  )))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is not set but MM_EXTERNAL_VOLUME_UP is set.");
            $success = 0;
        }

        my @command_list = ();
        if ($minimyth->var_get($name))
        {
            push(@command_list, minimyth->var_get($name));
        }
        if ($minimyth->var_get('MM_EXTERNAL_AQUOS_VOLUME_ENABLED') eq 'yes')
        {
            my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
            push(@command_list, qq(/bin/echo -e "MUTE TOGGLE\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1\n));
        }
        if ($#command_list >= 0)
        {
            unlink('/usr/bin/mm_external_volume_mute');

            if (open(FILE, '>', '/usr/bin/mm_external_volume_mute'))
            {
                chmod(0755, '/usr/bin/mm_external_volume_mute');
                print FILE qq(#!/bin/sh\n);
                foreach my $command (@command_list)
                {
                    print FILE qq($command\n);
                }
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE could not write '/usr/bin/mm_external_volume_mute'.");
                $success = 0;
            }
        }

        return $success;
    }
};
$var_list{'MM_EXTERNAL_AQUOS_ENABLED'} =
{
    prerequisite  => ['MM_EXTERNAL_AQUOS_DEVICE'],
    value_default => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $default = 'no';
        if ($minimyth->var_get('MM_EXTERNAL_AQUOS_DEVICE'))
        {
            $default = 'yes';
        }

        return $default;
    },
    value_valid   => 'no|yes'
};
$var_list{'MM_EXTERNAL_AQUOS_DEVICE'} =
{
    extra         => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $device = $minimyth->var_get($name);
        if (($device) && (! -e $device))
        {
            $minimyth->message_output('err', "Serial port device '$device' specified by '$name' does not exist.");
            return 0;
        }

        return 1;
    }
};
$var_list{'MM_EXTERNAL_AQUOS_PORT'} =
{
    value_default => '4684',
    value_valid   => '(\d+)'
};
$var_list{'MM_EXTERNAL_AQUOS_POWER_ENABLED'} =
{
    prerequisite  => ['MM_EXTERNAL_AQUOS_ENABLED'],
    value_default => sub
    {
        my $minimyth = shift;

        return $minimyth->var_get('MM_EXTERNAL_AQUOS_ENABLED');
    },
    value_valid   => 'no|yes'
};
$var_list{'MM_EXTERNAL_AQUOS_VOLUME_ENABLED'} =
{
    prerequisite  => ['MM_EXTERNAL_AQUOS_ENABLED'],
    value_default => sub
    {
        my $minimyth = shift;

        return $minimyth->var_get('MM_EXTERNAL_AQUOS_ENABLED');
    },
    value_valid   => 'no|yes'
};
$var_list{'MM_EXTERNAL_AQUOS_INPUT'} =
{
    value_valid   => '(|\d+)'
};

1;
