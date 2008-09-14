#!/usr/bin/perl
################################################################################
# mythtv
#
# This script configures MythTV.
################################################################################
package init::mythtv;

use strict;
use warnings;
use feature "switch";

require File::Basename;
require File::Path;
require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "configuring MythTV ...");

    # Set OSD fonts.
    $minimyth->mythdb_settings_set('OSDFont',   'FreeSans.ttf');
    $minimyth->mythdb_settings_set('OSDCCFont', 'FreeSans.ttf');

    given ($minimyth->var_get('MM_X_DRIVER'))
    {
        # Disable MythTV's use of OpenGL vertical sync when the intel Xorg driver
        # is used because it does not work.
        when (/^intel_810$/)
        {
            $minimyth->mythdb_settings_set('UseOpenGLVSync', '0');
        }
        when (/^intel_915$/)
        {
            $minimyth->mythdb_settings_set('UseOpenGLVSync', '0');
        }
        # Disable MythTV's use of OpenGL when the openchrome Xorg driver is used
        # because the unichrome_dri.so is unstable.
        when (/^openchrome$/)
        {
            $minimyth->mythdb_settings_set('SlideshowUseOpenGL', '0');
            $minimyth->mythdb_settings_set('ThemePainter', 'qt');
            $minimyth->mythdb_settings_set('UseOpenGLVSync', '0');
        }
    }

    my $theme_name = $minimyth->var_get('MM_THEME_NAME');
    my $theme_url  = $minimyth->var_get('MM_THEME_URL');
    # Set the MythTV theme.
    if ($theme_name)
    {
        $minimyth->mythdb_settings_set('Theme', $theme_name);
    }
    # Mount MythTV theme directory.
    if ($theme_url)
    {
        if (! $minimyth->url_mount($theme_url, "/usr/share/mythtv/themes/$theme_name"))
        {
            $minimyth->message_output('err', "error: mount of 'MM_THEME_URL=$theme_url' failed.");
            return 0;
        }
    }

    my $themeosd_name = $minimyth->var_get('MM_THEMEOSD_NAME');
    my $themeosd_url  = $minimyth->var_get('MM_THEMEOSD_URL');
    # Set the MythTV OSD theme.
    if ($themeosd_name)
    {
        $minimyth->mythdb_settings_set('OSDTheme', $themeosd_name);
    }
    # Mount MythTV OSD theme directory.
    if ($themeosd_url)
    {
        if (! $minimyth->url_mount($themeosd_url, "/usr/share/mythtv/themes/$themeosd_name"))
        {
            $minimyth->message_output('err', "error: mount of 'MM_THEMEOSD_URL=$themeosd_url' failed.");
            return 0;
        }
    }

    my $themecache_url  = $minimyth->var_get('MM_THEMECACHE_URL');
    # Mount themecache directory.
    if ($themecache_url)
    {
        $minimyth->url_mount($themecache_url, '/home/minimyth/.mythtv/themecache');
    }

    # Configure MythVideo DVD ripping.
    # Since mythfrontend is run as user 'minimyth', mtd is run as user 'minimyth'.
    # As a result, it is user 'minimyth' that must have the required read-write access.
    my $dvd_rip_url        = $minimyth->var_get('MM_MEDIA_DVD_RIP_URL');
    my $dvd_rip_mountpoint = $minimyth->var_get('MM_MEDIA_DVD_RIP_MOUNTPOINT');
    if (($dvd_rip_url) && ($dvd_rip_mountpoint))
    {
        my $mtd       = $minimyth->application_path('mtd');
        my $transcode = $minimyth->application_path('transcode');
        if ($mtd)
        {
            $minimyth->message_output('err', "error: 'mtd' not found.");
            return 0;
        }
        if (system(qq(/bin/su -c '/usr/bin/test ! -e $dvd_rip_mountpoint' - minimyth)) == 0)
        {
            $minimyth->message_output('err', "error: '$dvd_rip_mountpoint' does not exist.");
            return 0;
        }
        if (system(qq(/bin/su -c '/usr/bin/test ! -d $dvd_rip_mountpoint' - minimyth)) == 0)
        {
            $minimyth->message_output('err', "error: '$dvd_rip_mountpoint' is not a directory.");
            return 0;
        }
        if (system(qq(/bin/su -c '/usr/bin/test ! -w $dvd_rip_mountpoint' - minimyth)) == 0)
        {
            $minimyth->message_output('err', "error: '$dvd_rip_mountpoint' is not writable by user 'minimyth'.");
            return 0;
        }
        system(qq(/bin/su -c '/bin/mkdir -p $dvd_rip_mountpoint/.mtd' - minimyth));
        if (system(qq(/bin/su -c '/usr/bin/test ! -e $dvd_rip_mountpoint/.mtd' - minimyth)) == 0)
        {
            $minimyth->message_output('err', "error: '$dvd_rip_mountpoint/.mtd' does not exist.");
            return 0;
        }
        if (system(qq(/bin/su -c '/usr/bin/test ! -d $dvd_rip_mountpoint/.mtd' - minimyth)) == 0)
        {
            $minimyth->message_output('err', "error: '$dvd_rip_mountpoint/.mtd' is not a directory.");
            return 0;
        }
        if (system(qq(/bin/su -c '/usr/bin/test ! -w $dvd_rip_mountpoint/.mtd' - minimyth)) == 0)
        {
            $minimyth->message_output('err', "error: '$dvd_rip_mountpoint/.mtd' is not writable by user 'minimyth'.");
            return 0;
        }
        $minimyth->mythdb_settings_set('DVDRipLocation', "$dvd_rip_mountpoint/.mtd");
        $minimyth->mythdb_settings_set('TranscodeCommand', "$transcode");
        system(qq(/bin/su -c '$mtd --daemon' - minimyth));
    }

    # Configure Myth database jumppoints to match MiniMyth frontend.
    foreach ($minimyth->var_list({ 'filter' => 'MM_MYTHDB_JUMPPOINTS_.*' }))
    {
        if (/^([^~]+)~([^~]*)$/)
        {
            $minimyth->mythdb_jumppoints_update($1, $2);
        }
    }

    # Configure Myth database keybindings to match MiniMyth frontend.
    foreach ($minimyth->var_list({ 'filter' => 'MM_MYTHDB_KEYBINDINGS_.*' }))
    {
        if (/^([^~]+)~([^~]+)~([^~]*)$/)
        {
            $minimyth->mythdb_keybindings_update($1, $2, $3);
        }
    }

    # Configure Myth database settings to match MiniMyth frontend.
    foreach ($minimyth->var_list({ 'filter' => 'MM_MYTHDB_SETTINGS_.*' }))
    {
        if (/^([^~]+)~([^~]*)$/)
        {
            $minimyth->mythdb_settings_update($1, $2);
        }
    }

    # Delete disabled plugins.
    if ($minimyth->var_get('MM_PLUGIN_OPTICAL_DISK_ENABLED') eq 'no')
    {
        $minimyth->file_replace_variable(
            '/usr/share/mythtv/mainmenu.xml',
            { '<depends>mythmusic mythvideo mytharchive mythburn</depends>' => '<depends>disabled</depends>' });
    }
    my %plugin_remove = ();
    $plugin_remove{'MM_PLUGIN_BROWSER_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythbookmarkmanager.so',
          '/usr/share/mythtv/bookmark*',
          '/usr/share/mythtv/mythbookmarkmanager*',
          '/usr/share/mythtv/browser*',
          '/usr/share/mythtv/mythbrowser*' ];
    $plugin_remove{'MM_PLUGIN_GALLERY_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythgallery.so',
          '/usr/share/mythtv/gallery*',
          '/usr/share/mythtv/mythgallery*' ];
    $plugin_remove{'MM_PLUGIN_GAME_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythgame.so',
          '/usr/share/mythtv/game*',
          '/usr/share/mythtv/mythgame*' ];
    $plugin_remove{'MM_PLUGIN_MUSIC_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythmusic.so',
          '/usr/share/mythtv/music*',
          '/usr/share/mythtv/mythmusic*' ];
    $plugin_remove{'MM_PLUGIN_NEWS_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythnews.so',
          '/usr/share/mythtv/news*',
          '/usr/share/mythtv/mythnews*' ];
    $plugin_remove{'MM_PLUGIN_PHONE_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythphone.so',
          '/usr/share/mythtv/phone*',
          '/usr/share/mythtv/mythphone*' ];
    $plugin_remove{'MM_PLUGIN_STREAM_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythstream.so',
          '/usr/share/mythtv/stream*',
          '/usr/share/mythtv/mythstream*' ];
    $plugin_remove{'MM_PLUGIN_VIDEO_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythvideo.so',
          '/usr/share/mythtv/video*',
          '/usr/share/mythtv/mythvideo*' ];
    $plugin_remove{'MM_PLUGIN_WEATHER_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythweather.so',
          '/usr/share/mythtv/weather*',
          '/usr/share/mythtv/mythweather*' ];
    $plugin_remove{'MM_PLUGIN_ZONEMINDER_ENABLED'} =
        [ '/usr/lib/mythtv/plugins/libmythzoneminder.so',
          '/usr/share/mythtv/zoneminder*',
          '/usr/share/mythtv/mythzoneminder*' ];
    foreach my $plugin (keys %plugin_remove)
    {
        if ($minimyth->var_get($plugin) eq 'no')
        {
            foreach (@{$plugin_remove{$plugin}})
            {
                my $dir = File::Basename::dirname($_);
                if (opendir(DIR, $dir))
                {
                    my $filter = File::Basename::basename($_);
                    foreach (grep(/^$filter$/, readdir(DIR)))
                    {
                        if (-f qq($dir/$_))
                        {
                            unlink(qq($dir/$_));
                        }
                        else
                        {
                            File::Path::rmtree(qq($dir/$_));
                        }
                    }
                    closedir(DIR);
                }
            }
        }
    }

    # Check for libdvdcss.so.2
    if ($minimyth->var_get('MM_PLUGIN_VIDEO_ENABLED') eq 'yes')
    {
        my $found = 0;
        if ((-e '/etc/ld.so.conf') && (open(FILE, '<', '/etc/ld.so.conf')))
        {
            while (<FILE>)
            {
                chomp;
                if (-e "$_/libdvdcss.so.2")
                {
                    $found = 1;
                    last
                }
            }
            close(FILE);
        }
        if ($found == 0)
        {
            my $hostname = $minimyth->hostname();
            $minimyth->message_log('warn',
                                   "warning: certain DVDs may not play. see <http://$hostname/minimyth/document-faq.html#dvd>");
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('mtd');

    return 1;
}

1;
