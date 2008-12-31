#!/usr/bin/perl
################################################################################
# MM_VIDEO configuration variable handlers.
################################################################################
package init::conf::MM_VIDEO;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_VIDEO_ASPECT_RATIO'} =
{
    value_default  => '4:3',
    value_valid    => '4:3|16:9|16:10'
};
$var_list{'MM_VIDEO_DECODER'} =
{
    value_default  => 'auto',
    value_valid    =>       'auto' .
                      '|' . 'ffmpeg' .
                      '|' . 'libmpeg2' .
                      '|' . 'vdpau' .
                      '|' . 'xvmc' .
                      '|' . 'xvmc-vld',
    value_none     => ''
};
$var_list{'MM_VIDEO_DEINTERLACER'} =
{
    prerequisite   => ['MM_VERSION_MYTH_BINARY_MAJOR', 'MM_VERSION_MYTH_BINARY_MINOR'],
    value_default  => 'none',
    value_valid    => sub
    {
        my $minimyth = shift;
        my $name     = shift;
        
        my $value_valid = '';
        if    ( ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MAJOR') ==  0) &&
                ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MINOR') == 20) )
        {
            $value_valid =       'auto' .
                           '|' . 'none' .
                           '|' . 'bobdeint' .
                           '|' . 'kerneldeint' .
                           '|' . 'linearblend' .
                           '|' . 'onefield';
        }
        elsif ( ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MAJOR') ==  0) &&
                ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MINOR') == 21) )
        {
            $value_valid =       'auto' .
                           '|' . 'none' .
                           '|' . 'bobdeint' .
                           '|' . 'greedyhdeint' .
                           '|' . 'greedyhdoubleprocessdeint' .
                           '|' . 'kerneldeint' .
                           '|' . 'linearblend' .
                           '|' . 'onefield' .
                           '|' . 'openglbobdeint' .
                           '|' . 'opengldoubleratefieldorder' .
                           '|' . 'opengldoubleratekerneldeint' .
                           '|' . 'opengldoubleratelinearblend' .
                           '|' . 'opengldoublerateonefield' .
                           '|' . 'openglkerneldeint' .
                           '|' . 'opengllinearblend' .
                           '|' . 'openglonefield' .
                           '|' . 'yadifdeint' .
                           '|' . 'yadifdoubleprocessdeint';
        }
        else
        {
            $value_valid =       'auto' .
                           '|' . 'none' .
                           '|' . 'bobdeint' .
                           '|' . 'greedyhdeint' .
                           '|' . 'greedyhdoubleprocessdeint' .
                           '|' . 'kerneldeint' .
                           '|' . 'linearblend' .
                           '|' . 'onefield' .
                           '|' . 'openglbobdeint' .
                           '|' . 'opengldoubleratefieldorder' .
                           '|' . 'opengldoubleratekerneldeint' .
                           '|' . 'opengldoubleratelinearblend' .
                           '|' . 'opengldoublerateonefield' .
                           '|' . 'openglkerneldeint' .
                           '|' . 'opengllinearblend' .
                           '|' . 'openglonefield' .
                           '|' . 'vdpauadvanced' .
                           '|' . 'vdpauadvanceddoublerate' .
                           '|' . 'vdpaubasic' .
                           '|' . 'vdpaubasicdoublerate' .
                           '|' . 'vdpaubobdeint' .
                           '|' . 'vdpauonefield' .
                           '|' . 'yadifdeint' .
                           '|' . 'yadifdoubleprocessdeint';
        }
    }
};
$var_list{'MM_VIDEO_FONT_SCALE'} =
{
    value_default  => '100',
    value_valid    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value = $minimyth->var_get($name);
        return '[0-9]+' if (! $value);
        return '[0-9]+' if ($value =~ /[0-9]+/);
        return ''       if ($value <  25);
        return ''       if ($value > 400);
        return '[0-9]+';
    }
};
$var_list{'MM_VIDEO_PLAYBACK_PROFILE'} =
{
    prerequisite   => ['MM_VERSION_MYTH_BINARY_MAJOR', 'MM_VERSION_MYTH_BINARY_MINOR'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;
        
        my $value_default = '';
        if ( ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MAJOR') ==  0) &&
             ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MINOR') == 20) )
        {
            $value_default = 'none';
        }
        else
        {
            $value_default = 'MiniMyth';
        }

        return $value_default;
    },
    value_valid    => 'none|.+',
    value_none     => ''
};
$var_list{'MM_VIDEO_RESIZE_ENABLED'} =
{
    value_default  => '',
    value_valid    => '|no|yes'
};

1;
