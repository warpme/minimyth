#!/usr/bin/perl
################################################################################
# media
#
# This script mounts the remote media directories.
################################################################################
package init::media;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "mounting media shares ...");

    foreach my $media (('TV', 'GALLERY', 'GAME', 'MUSIC', 'VIDEO', 'DVD_RIP'))
    {
        my $url_name        = 'MM_MEDIA_' . $media . '_URL';
        my $mountpoint_name = 'MM_MEDIA_' . $media . '_MOUNTPOINT';
        my $url             = $minimyth->var_get($url_name);
        my $mountpoint      = $minimyth->var_get($mountpoint_name);
        if (($url) && ($mountpoint))
        {
            $minimyth->url_mount($url, $mountpoint);
            if (open(FILE, '<', '/proc/mounts'))
            {
                my $mounted = 0;
                foreach (grep(/^[^ ]* $mountpoint/, (<FILE>)))
                {
                    $mounted = 1;
                }
                close(FILE);
                if ($mounted == 0)
                {
                    $minimyth->message_output('err', "error: '$mountpoint' failed to mount.");
                    return 0;
                }
            }
            if (system(qq(/bin/su -c '/usr/bin/test ! -r $mountpoint' - minimyth)) == 0)
            {
                $minimyth->message_output('err', "error: '$mountpoint' is not readable by user 'minimyth'.");
                return 0;
            }
            if ($mountpoint_name eq 'MM_MEDIA_TV_MOUNTPOINT')
            {
                if ($minimyth->var_get('MM_BACKEND_ENABLED') eq 'yes')
                {
                    if (system(qq(/bin/su -c '/usr/bin/test ! -w $mountpoint' - minimyth)) == 0)
                    {
                        $minimyth->message_output('err', "error: '$mountpoint' is not writable by user 'minimyth'.");
                        return 0;
                    }
                }
            }
            if ($mountpoint_name eq 'MM_MEDIA_DVD_RIP_MOUNTPOINT')
            {
                if (system(qq(/bin/su -c '/usr/bin/test ! -w $mountpoint' - minimyth)) == 0)
                {
                    $minimyth->message_output('err', "error: '$mountpoint' is not writable by user 'minimyth'.");
                    return 0;
                }
            }
        }
    }

    $minimyth->file_replace_variable(
        '/home/minimyth/.xine/config',
        { '@MEDIA_FILES_ORIGIN_PATH@' => $minimyth->var_get('MM_MEDIA_VIDEO_MOUNTPOINT') });

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "unmounting media shares ...");

    foreach my $media (('DVD_RIP', 'VIDEO', 'MUSIC', 'GAME', 'GALLERY', 'TV'))
    {
        my $url_name        = 'MM_MEDIA_' . $media . '_URL';
        my $mountpoint_name = 'MM_MEDIA_' . $media . '_MOUNTPOINT';
        my $url             = $minimyth->var_get($url_name);
        my $mountpoint      = $minimyth->var_get($mountpoint_name);

        if (($url) && ($mountpoint))
        {
            if (open(FILE, '<', '/proc/mounts'))
            {
                my $mounted = 0;
                foreach (grep(/^[^ ]* $mountpoint/, (<FILE>)))
                {
                    $mounted = 1;
                }
                close(FILE);
                if ($mounted != 0)
                {
                    system(qq(/bin/umount "$mountpoint"));
                }
            }
        }
    }

    return 1;
}

1;
