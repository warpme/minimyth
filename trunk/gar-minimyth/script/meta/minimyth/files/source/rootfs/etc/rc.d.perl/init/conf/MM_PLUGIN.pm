#!/usr/bin/perl
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

1;
