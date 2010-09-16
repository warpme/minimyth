################################################################################
# MM_PLUGIN configuration variable handlers.
################################################################################
package init::conf::MM_PLUGIN;

use strict;
use warnings;
use feature "switch";

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_PLUGIN_INFORMATION_CENTER_ENABLED'} =
{
    value_default  => 'yes',
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_OPTICAL_DISK_ENABLED'} =
{
    value_default  => 'yes',
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_BROWSER_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythbrowser.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_GALLERY_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythgallery.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_GAME_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythgame.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_MUSIC_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythmusic.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_NETVISION_ENABLED'} =
{
    prerequisite   => ['MM_PLUGIN_BROWSER_ENABLED', 'MM_VERSION_MYTH_BINARY_MINOR'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        given ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MINOR'))
        {
            when (/^22$/)
            {
                return 'no';
            }
            default
            {
                if ((-e '/usr/lib/mythtv/plugins/libmythnetvision.so')         &&
                    ($minimyth->var_get('MM_PLUGIN_BROWSER_ENABLED') eq 'yes'))
                {
                    return 'yes';
                }
                else
                {
                    return 'no';
                }
            }
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_NEWS_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythnews.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_STREAM_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythstream.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_VIDEO_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythvideo.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_WEATHER_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythweather.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_ZONEMINDER_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythzoneminder.so')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_KERNEL_MODULE_LIST'} =
{
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

        return join(' ', @kernel_modules);
    }
};

1;
