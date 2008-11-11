#!/usr/bin/perl
################################################################################
# MM_MEDIA configuration variable handlers.
################################################################################
package init::conf::MM_MEDIA;

use strict;
use warnings;

my $dir = '/|(/[[:alnum:]._-]+)+';
my $url = '(cifs|nfs):(//(([^ :@]*)?(:([^ @]*))?\@)?([^ /]+))?[^ ?#]*(\?([^ #]*))?(\#([^ ]*))?';

my $value_valid_mountpoint = qq/$dir/;
my $value_valid_url        = qq/none|$url/;
my $value_valid_list       = qq/none|((($dir)=($url))( ($dir)=($url))*)/;
my $value_clean_list       = sub
{
    my $minimyth = shift;
    my $name     = shift;

    my $value_clean = $minimyth->var_get($name);
    $value_clean =~ s/[ [:cntrl:]]+/ /g;
    $value_clean =~ s/^ //g;
    $value_clean =~ s/ $//g;
    $minimyth->var_set($name, $value_clean);
};

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_MEDIA_TV_MOUNTPOINT'} =
{
    value_default  => '/mnt/tv',
    value_valid    => $value_valid_mountpoint
};
$var_list{'MM_MEDIA_TV_URL'} =
{
    value_default  => 'none',
    value_valid    => $value_valid_url,
    value_none     => ''
};
$var_list{'MM_MEDIA_GALLERY_MOUNTPOINT'} =
{
    value_default  => '/mnt/gallery',
    value_valid    => $value_valid_mountpoint
};
$var_list{'MM_MEDIA_GALLERY_URL'} =
{
    value_default  => 'none',
    value_valid    => $value_valid_url,
    value_none     => ''
};
$var_list{'MM_MEDIA_GAME_MOUNTPOINT'} =
{
    value_default  => '/mnt/game',
    value_valid    => $value_valid_mountpoint
};
$var_list{'MM_MEDIA_GAME_URL'} =
{
    value_default  => 'none',
    value_valid    => $value_valid_url,
    value_none     => ''
};
$var_list{'MM_MEDIA_MUSIC_MOUNTPOINT'} =
{
    value_default  => '/mnt/music',
    value_valid    => $value_valid_mountpoint
};
$var_list{'MM_MEDIA_MUSIC_URL'} =
{
    value_default  => 'none',
    value_valid    => $value_valid_url,
    value_none     => ''
};
$var_list{'MM_MEDIA_VIDEO_MOUNTPOINT'} =
{
    value_default  => '/mnt/video',
    value_valid    => $value_valid_mountpoint
};
$var_list{'MM_MEDIA_VIDEO_URL'} =
{
    value_default  => 'none',
    value_valid    => $value_valid_url,
    value_none     => ''
};
$var_list{'MM_MEDIA_DVD_RIP_MOUNTPOINT'} =
{
    value_default  => '/mnt/dvd',
    value_valid    => $value_valid_mountpoint
};
$var_list{'MM_MEDIA_DVD_RIP_URL'} =
{
    value_default  => 'none',
    value_valid    => $value_valid_url,
    value_none     => ''
};
$var_list{'MM_MEDIA_GENERIC_LIST'} =
{
    value_clean    => $value_clean_list,
    value_default  => 'none',
    value_valid    => $value_valid_list,
    value_none     => ''
};

1;
