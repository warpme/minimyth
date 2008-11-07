#!/usr/bin/perl
################################################################################
# MM_MEDIA configuration variable handlers.
################################################################################
package init::conf::MM_MEDIA;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_MEDIA_TV_MOUNTPOINT'} =
{
    value_default  => '/mnt/tv'
};
$var_list{'MM_MEDIA_TV_URL'} =
{
    value_default  => 'none',
    value_valid    => 'none|((cifs|nfs):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_none     => ''
};
$var_list{'MM_MEDIA_GALLERY_MOUNTPOINT'} =
{
    value_default  => '/mnt/gallery'
};
$var_list{'MM_MEDIA_GALLERY_URL'} =
{
    value_default  => 'none',
    value_valid    => 'none|((cifs|nfs):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_none     => ''
};
$var_list{'MM_MEDIA_GAME_MOUNTPOINT'} =
{
    value_default  => '/mnt/game'
};
$var_list{'MM_MEDIA_GAME_URL'} =
{
    value_default  => 'none',
    value_valid    => 'none|((cifs|nfs):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_none     => ''
};
$var_list{'MM_MEDIA_MUSIC_MOUNTPOINT'} =
{
    value_default  => '/mnt/music'
};
$var_list{'MM_MEDIA_MUSIC_URL'} =
{
    value_default  => 'none',
    value_valid    => 'none|((cifs|nfs):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_none     => ''
};
$var_list{'MM_MEDIA_VIDEO_MOUNTPOINT'} =
{
    value_default  => '/mnt/video'
};
$var_list{'MM_MEDIA_VIDEO_URL'} =
{
    value_default  => 'none',
    value_valid    => 'none|((cifs|nfs):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_none     => ''
};
$var_list{'MM_MEDIA_DVD_RIP_MOUNTPOINT'} =
{
    value_default  => '/mnt/dvd'
};
$var_list{'MM_MEDIA_DVD_RIP_URL'} =
{
    value_default  => 'none',
    value_valid    => 'none|((cifs|nfs):(//(([^:@]*)?(:([^@]*))?\@)?([^/]+))?[^?#]*(\?([^#]*))?(\#(.*))?)',
    value_none     => ''
};

1;
