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
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        unlink('/usr/bin/mm_external_power_off');

        if (open(FILE, '>', '/usr/bin/mm_external_power_off'))
        {
            chmod(0755, '/usr/bin/mm_external_power_off');
            print FILE qq(#!/bin/sh\n);

            my $command = $minimyth->var_get($name);
            if ($command)
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

        return $success;
    }
};
$var_list{'MM_EXTERNAL_POWER_ON'} =
{
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        unlink('/usr/bin/mm_external_power_on');

        if (open(FILE, '>', '/usr/bin/mm_external_power_on'))
        {
            chmod(0755, '/usr/bin/mm_external_power_on');
            print FILE qq(#!/bin/sh\n);

            my $command = $minimyth->var_get($name);
            if ($command)
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

        return $success;
    }
};
$var_list{'MM_EXTERNAL_VOLUME_DOWN'} =
{
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        unlink('/usr/bin/mm_external_volume_down');

        if (open(FILE, '>', '/usr/bin/mm_external_volume_down'))
        {
            chmod(0755, '/usr/bin/mm_external_volume_down');
            print FILE qq(#!/bin/sh\n);

            my $command = $minimyth->var_get($name);
            if ($command)
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

        return $success;
    }
};
$var_list{'MM_EXTERNAL_VOLUME_UP'} =
{
    prerequisite   => ['MM_EXTERNAL_VOLUME_DOWN'],
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

        unlink('/usr/bin/mm_external_volume_up');

        if (open(FILE, '>', '/usr/bin/mm_external_volume_up'))
        {
            chmod(0755, '/usr/bin/mm_external_volume_up');
            print FILE qq(#!/bin/sh\n);

            my $command = $minimyth->var_get($name);
            if ($command)
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

        return $success;
    }
};
$var_list{'MM_EXTERNAL_VOLUME_MUTE'} =
{
    prerequisite   => ['MM_EXTERNAL_VOLUME_DOWN', 'MM_EXTERNAL_VOLUME_UP'],
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

        if (open(FILE, '>>', '/usr/bin/mm_external_volume_mute'))
        {
            chmod(0755, '/usr/bin/mm_external_volume_mute');
            print FILE qq(#!/bin/sh\n);

            my $command = $minimyth->var_get($name);
            if ($command)
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
    prerequisite  => ['MM_EXTERNAL_AQUOS_ENABLED', 'MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_POWER_OFF', 'MM_EXTERNAL_POWER_ON'],
    value_default => sub
    {
        my $minimyth = shift;

        return $minimyth->var_get('MM_EXTERNAL_AQUOS_ENABLED');
    },
    value_valid   => 'no|yes',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        if ($minimyth->var_get($name) eq 'yes')
        {
            if (open(FILE, '>>', '/usr/bin/mm_external_power_off'))
            {
                chmod(0755, '/usr/bin/mm_external_power_off');
                my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
                print FILE qq(/bin/echo -e "POWER OFF\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1\n);
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_AQUOS_POWER_ENABLED could not write '/usr/bin/mm_external_power_off'.");
                $success = 0;
            }
            if (open(FILE, '>>', '/usr/bin/mm_external_power_on'))
            {
                chmod(0755, '/usr/bin/mm_external_power_on');
                my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
                print FILE qq(/bin/echo -e "POWER ON\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1\n);
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_AQUOS_POWER_ENABLED could not write '/usr/bin/mm_external_power_on'.");
                $success = 0;
            }
        }

        return $success;
    }
};
$var_list{'MM_EXTERNAL_AQUOS_VOLUME_ENABLED'} =
{
    prerequisite  => ['MM_EXTERNAL_AQUOS_ENABLED', 'MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_VOLUME_DOWN', 'MM_EXTERNAL_VOLUME_UP', 'MM_EXTERNAL_VOLUME_MUTE'],
    value_default => sub
    {
        my $minimyth = shift;

        return $minimyth->var_get('MM_EXTERNAL_AQUOS_ENABLED');
    },
    value_valid   => 'no|yes',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        if ($minimyth->var_get($name) eq 'yes')
        {
            if (open(FILE, '>>', '/usr/bin/mm_external_volume_down'))
            {
                chmod(0755, '/usr/bin/mm_external_volume_down');
                my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
                print FILE qq(/bin/echo -e "VOL -\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1\n);
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_AQUOS_VOLUME_ENABLED could not write '/usr/bin/mm_external_volume_down'.");
                $success = 0;
            }
            if (open(FILE, '>>', '/usr/bin/mm_external_volume_up'))
            {
                chmod(0755, '/usr/bin/mm_external_volume_up');
                my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
                print FILE qq(/bin/echo -e "VOL +\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1\n);
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_AQUOS_VOLUME_ENABLED could not write '/usr/bin/mm_external_volume_up'.");
                $success = 0;
            }
            if (open(FILE, '>>', '/usr/bin/mm_external_volume_mute'))
            {
                chmod(0755, '/usr/bin/mm_external_volume_mute');
                my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
                print FILE qq(/bin/echo -e "MUTE TOGGLE\\nEXIT" | /usr/bin/nc localhost $port > /dev/null 2>&1\n);
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_AQUOS_VOLUME_ENABLED could not write '/usr/bin/mm_external_volume_mute'.");
                $success = 0;
            }
        }

        return $success;
    }
};
$var_list{'MM_EXTERNAL_AQUOS_INPUT'} =
{
    prerequisite  => ['MM_EXTERNAL_AQUOS_PORT', 'MM_EXTERNAL_AQUOS_POWER_ENABLED'],
    value_valid   => '(|\d+)',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;

        my $input = $minimyth->var_get($name);
        if ($input)
        {
            if (open(FILE, '>>', '/usr/bin/mm_external_power_on'))
            {
                chmod(0755, '/usr/bin/mm_external_power_on');
                my $port = $minimyth->var_get('MM_EXTERNAL_AQUOS_PORT');
                print FILE qq(while /usr/bin/test `/bin/echo -e "CMD IAVD $input\\nEXIT" | /usr/bin/nc localhost $port 2> /dev/null` = 'ERR' ; do\n);
                print FILE qq(    :\n);
                print FILE qq(done\n);
                close(FILE);
            }
            else
            {
                $minimyth->message_output('err', "MM_EXTERNAL_AQUOS_INPUT could not write '/usr/bin/mm_external_power_on'.");
                $success = 0;
            }
        }

        return $success;
    }
};

1;
