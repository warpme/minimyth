################################################################################
# MM_PLUGIN configuration variable handlers.
################################################################################
package init::conf::MM_PLUGIN;

use strict;
use warnings;

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

        if (-e '/usr/lib/mythtv/plugins/libmythbookmarkmanager.so')
        {
            return 'yes'
        }
        else
        {
            return 'no'
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_DVD_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythdvd.so')
        {
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_PHONE_ENABLED'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/usr/lib/mythtv/plugins/libmythphone.so')
        {
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
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
            return 'yes'
        }
        else
        {
            return 'no'
        }
    },
    value_valid    => 'no|yes'
};
$var_list{'MM_PLUGIN_KERNEL_MODULE_LIST'} =
{
    prerequisite   => ['MM_PLUGIN_PHONE_ENABLED'],
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

        # MythPhone uses OSS not ALSA.
        if ($minimyth->var_get('MM_PLUGIN_PHONE_ENABLED') eq 'yes')
        {
            push(@kernel_modules, 'snd-pcm-oss');
        }

        return join(' ', @kernel_modules);
    }
};

1;
