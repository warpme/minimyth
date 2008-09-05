#!/usr/bin/perl
################################################################################
# x
################################################################################
package init::x;

use strict;
use warnings;
use feature "switch";

require File::Basename;
require File::Find;
require File::Path;
require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "configuring X ...");

    {
        my $uid = getpwnam('root');
        my $gid = getgrnam('root');
        rmdir('/tmp/.ICE-unix');
        mkdir('/tmp/.ICE-unix');
        chmod(01777,      '/tmp/.ICE-unix');
        chown($uid, $gid, '/tmp/.ICE-unix');
    }

    given ($minimyth->var_get('MM_X_SCREENSAVER_HACK'))
    {
        when (/^sleep$/)
        {
            $minimyth->file_replace_variable(
                '/home/minimyth/.xscreensaver',
                { '@MODE@'                        => 'blank',
                  '@SELECTED@'                    => '0',
                  '@MM_X_SCREENSAVER_TIMEOUT@'    => $minimyth->var_get('MM_X_SCREENSAVER_TIMEOUT'),
                  '@MM_MEDIA_GALLERY_MOUNTPOINT@' => $minimyth->var_get('MM_MEDIA_GALLERY_MOUNTPOINT') });
        }
        when (/^blank$/)
        {
            $minimyth->file_replace_variable(
                '/home/minimyth/.xscreensaver',
                { '@MODE@'                        => 'blank',
                  '@SELECTED@'                    => '0',
                  '@MM_X_SCREENSAVER_TIMEOUT@'    => $minimyth->var_get('MM_X_SCREENSAVER_TIMEOUT'),
                  '@MM_MEDIA_GALLERY_MOUNTPOINT@' => $minimyth->var_get('MM_MEDIA_GALLERY_MOUNTPOINT') });
        }
        when (/^glslideshow$/)
        {
            $minimyth->file_replace_variable(
                '/home/minimyth/.xscreensaver',
                { '@MODE@'                        => 'one',
                  '@SELECTED@'                    => '1',
                  '@MM_X_SCREENSAVER_TIMEOUT@'    => $minimyth->var_get('MM_X_SCREENSAVER_TIMEOUT'),
                  '@MM_MEDIA_GALLERY_MOUNTPOINT@' => $minimyth->var_get('MM_MEDIA_GALLERY_MOUNTPOINT') });
        }
        default
        {
            $minimyth->file_replace_variable(
                '/home/minimyth/.xscreensaver',
                { '@MODE@'                        => 'blank',
                  '@SELECTED@'                    => '0',
                  '@MM_X_SCREENSAVER_TIMEOUT@'    => $minimyth->var_get('MM_X_SCREENSAVER_TIMEOUT'),
                  '@MM_MEDIA_GALLERY_MOUNTPOINT@' => $minimyth->var_get('MM_MEDIA_GALLERY_MOUNTPOINT') });
        }
    }

    my $displaysize_x;
    my $displaysize_y;
    if ($minimyth->var_get('MM_X_DISPLAYSIZE') =~ /^([0-9]+)x([0-9]+)$/)
    {
        $displaysize_x = $1;
        $displaysize_y = $2;
    }

    my $virtual_x;
    my $virtual_y;
    if ($minimyth->var_get('MM_X_VIRTUAL') =~ /^([0-9]+)x([0-9]+)$/)
    {
        $virtual_x = $1;
        $virtual_y = $2;
    }

    my $device_intel  = '';
    my $device_nvidia = '';
    my $device_via    = '';
    given ($minimyth->var_get('MM_X_DRIVER'))
    {
        when (/^intel_810|intel_915$/)
        {
            given ($minimyth->var_get('MM_X_OUTPUT_TV'))
            {
                when (/^auto$/)     { $device_intel = 'TV';       }
                when (/^([0-9]+)$/) { $device_intel = 'TV-' . $1; }
            }
            given ($minimyth->var_get('MM_X_OUTPUT_VGA'))
            {
                when (/^auto$/)     { $device_intel = 'VGA';       }
                when (/^([0-9]+)$/) { $device_intel = 'VGA-' . $1; }
            }
            given ($minimyth->var_get('MM_X_OUTPUT_VGA'))
            {
                when (/^auto$/)     { $device_intel = 'TMDS';       }
                when (/^([0-9]+)$/) { $device_intel = 'TMDS-' . $1; }
            }
        }
        when (/^nvidia$/)
        {
            given ($minimyth->var_get('MM_X_OUTPUT_TV'))
            {
                when (/^auto$/)     { $device_nvidia = 'TV';       }
                when (/^([0-9]+)$/) { $device_nvidia = 'TV-' . $1; }
            }
            given ($minimyth->var_get('MM_X_OUTPUT_VGA'))
            {
                when (/^auto$/)     { $device_nvidia = 'CRT';       }
                when (/^([0-9]+)$/) { $device_nvidia = 'CRT-' . $1; }
            }
            given ($minimyth->var_get('MM_X_OUTPUT_DVI'))
            {
                when (/^auto$/)     { $device_nvidia = 'DFP';       }
                when (/^([0-9]+)$/) { $device_nvidia = 'DFP-' . $1; }
            }
            if ($device_nvidia eq '')
            {
                $minimyth->message_output('err', "error: no X video output enabled.");
                return 0;
            }
        }
        when (/^openchrome$/)
        {
            given ($minimyth->var_get('MM_X_OUTPUT_TV'))
            {
                when (/^auto$/)     { $device_via .= ',' if ($device_via ne '') ; $device_via .= 'TV'; }
                when (/^([0-9]+)$/) { $device_via .= ',' if ($device_via ne '') ; $device_via .= 'TV'; }
            }
            given ($minimyth->var_get('MM_X_OUTPUT_VGA'))
            {
                when (/^auto$/)     { $device_via .= ',' if ($device_via ne '') ; $device_via .= 'CRT'; }
                when (/^([0-9]+)$/) { $device_via .= ',' if ($device_via ne '') ; $device_via .= 'CRT'; }
            }
            given ($minimyth->var_get('MM_X_OUTPUT_DVI'))
            {
                when (/^auto$/)     { $device_via .= ',' if ($device_via ne '') ; $device_via .= 'LCD'; }
                when (/^([0-9]+)$/) { $device_via .= ',' if ($device_via ne '') ; $device_via .= 'LCD'; }
            }
            if ($device_via eq '')
            {
                $minimyth->message_output('err', "error: no X video output enabled.");
                return 0;
            }
        }
        when (/^vmware$/)
        {
        }
    }

    # Hacks to deal with the fact that the names for proprietary drivers and
    # open source drivers conflict.
    #   the proprietary NVIDIA GL libraries conflict with the Open Source Mesa GL libraries.
    my $dri_true    = '';
    my $nvidia_true = '#';
    given ($minimyth->var_get('MM_X_DRIVER'))
    {
        when (/^(intel_810|intel_915)$/)
        {
        }
        when (/^(nvidia)$/)
        {
            $dri_true    = '#';
            $nvidia_true = '';
            # Include path to proprietary libraries.
            {
                my @lib_path;
                push (@lib_path, '/usr/lib/nvidia');
                if ((-r '/etc/ld.so.conf') && open(FILE, '<', '/etc/ld.so.conf'))
                {
                    while (<FILE>)
                    {
                        chomp;
                        push (@lib_path, $_);
                    }
                    close(FILE);
                }
                if ((-w '/etc/ld.so.conf') && open(FILE, '>', '/etc/ld.so.conf'))
                {
                    foreach (@lib_path)
                    {
                        print FILE $_ . "\n";
                    }
                    close(FILE);
                }
            }
            # Remove Open Source libraries that conflict with proprietary libraries.
            {
                my @lib_name = ();
                File::Find::find(
                    sub
                    {
                        if (-f $File::Find::name)
                        {
                            my $file = File::Basename::basename($File::Find::name);
                            push(@lib_name, $file);
                        }
                    },
                    '/usr/lib/nvidia');
                my $lib_filter = join('|', @lib_name);
                if ($lib_filter)
                {
                    my @lib_path = ();
                    File::Find::find(
                        sub
                        {
                            my $file = File::Basename::basename($File::Find::name);
                            if ((-f $File::Find::name) && ($File::Find::dir !~ /^\/usr\/lib\/nvidia(\/.*)?$/) && ($file =~ /^$lib_filter$/))
                            {
                                push(@lib_path, $file);
                            }
                        },
                        '/usr/lib');
                    for (@lib_path)
                    {
                        if (-f $_)
                        {
                            unlink($_);
                        }
                    }
                }
            }
            # Rebuild library cache.
            system(qq(/sbin/ldconfig));
        }
        when (/^(radeon)$/)
        {
        }
        when (/^(sis)$/)
        {
        }
        when (/^(openchrome)$/)
        {
        }
        when (/^(vmware)$/)
        {
        }
    }

    my $mode   = $minimyth->var_get('MM_X_MODE');
    my $mode_0 = $minimyth->var_get('MM_X_MODE_0');
    my $mode_1 = $minimyth->var_get('MM_X_MODE_1');
    my $mode_2 = $minimyth->var_get('MM_X_MODE_2');

    $mode    = '' if ($mode   eq 'none');
    $mode_0  = '' if ($mode_0 eq 'none');
    $mode_1  = '' if ($mode_1 eq 'none');
    $mode_2  = '' if ($mode_2 eq 'none');

    # Add quotes because they cannot be quoted directly in xorg.conf.
    $mode   = '"' . $mode   . '"' if ($mode   ne '');
    $mode_0 = '"' . $mode_0 . '"' if ($mode_0 ne '');
    $mode_1 = '"' . $mode_1 . '"' if ($mode_1 ne '');
    $mode_2 = '"' . $mode_2 . '"' if ($mode_2 ne '');

    $minimyth->file_replace_variable(
        '/etc/X11/xorg.conf',
        { '@MM_X_DRIVER@'        => $minimyth->var_get('MM_X_DRIVER')     ,
          '@MM_X_DEVICE_INTEL@'  => $device_intel                         ,
          '@MM_X_DEVICE_NVIDIA@' => $device_nvidia                        ,
          '@MM_X_DEVICE_VIA@'    => $device_via                           ,
          '@MM_X_TV_TYPE@'       => $minimyth->var_get('MM_X_TV_TYPE')    ,
          '@MM_X_TV_OUTPUT@'     => $minimyth->var_get('MM_X_TV_OUTPUT')  ,
          '@MM_X_TV_OVERSCAN@'   => $minimyth->var_get('MM_X_TV_OVERSCAN'),
          '@MM_X_SYNC@'          => $minimyth->var_get('MM_X_SYNC')       ,
          '@MM_X_REFRESH@'       => $minimyth->var_get('MM_X_REFRESH')    ,
          '@MM_X_MODELINE@'      => $minimyth->var_get('MM_X_MODELINE')   ,
          '@MM_X_MODELINE_0@'    => $minimyth->var_get('MM_X_MODELINE_0') ,
          '@MM_X_MODELINE_1@'    => $minimyth->var_get('MM_X_MODELINE_1') ,
          '@MM_X_MODELINE_2@'    => $minimyth->var_get('MM_X_MODELINE_2') ,
          '@MM_X_MODE@'          => $mode                                 ,
          '@MM_X_MODE_0@'        => $mode_0                               ,
          '@MM_X_MODE_1@'        => $mode_1                               ,
          '@MM_X_MODE_2@'        => $mode_2                               ,
          '@X_DISPLAYSIZE_X@'    => $displaysize_x                        ,
          '@X_DISPLAYSIZE_Y@'    => $displaysize_y                        ,
          '@X_VIRTUAL_X@'        => $virtual_x                            ,
          '@X_VIRTUAL_Y@'        => $virtual_y                            ,
          '@DRI_TRUE@'           => $dri_true                             ,
          '@NVIDIA_TRUE@'        => $nvidia_true                           });

    # Make sure that the file ownership is correct.
    {
        my $uid = getpwnam('minimyth');
        my $gid = getgrnam('minimyth');
        File::Find::finddepth(
            sub
            {
                chown($uid, $gid, $File::Find::name);
            },
            '/home/minimyth');
    }

    $minimyth->message_output('info', "starting X ...");
    $minimyth->x_start();

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "stopping X ...");
    $minimyth->application_stop('mm_sleep_on_xscreensaver');
    $minimyth->x_stop();

    return 1;
}

1;
