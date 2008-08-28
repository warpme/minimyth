#!/usr/bin/perl
################################################################################
# MM_GAME configuration variable handlers.
################################################################################
package init::conf::MM_GAME;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_GAME_SAVE_ENABLED'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
};
$var_list{'MM_GAME_SAVE_LIST'} =
{
    value_clean    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = ':' . $minimyth->var_get($name);
        $value_clean =~ s/::+/:/g;
        $value_clean =~ s/\/\/+/\//g;
        $value_clean =~ s/:\//:/g;
        $value_clean =~ s/^://;
        $value_clean =~ s/:$//;
        $minimyth->var_set($name, $value_clean);
    },
    value_default  =>       '.fceultra' .
                      ':' . '.jzintv' .
                      ':' . '.mednafen' .
                      ':' . '.stella' .
                      ':' . '.mame' .
                      ':' . '.vba' .
                      ':' . '.zsnes' .
                      ':' . 'VisualBoyAdvance.cfg'
};
$var_list{'MM_GAME_BIOS_ROOT'} =
{
    prerequisite   => ['MM_MEDIA_GAME_MOUNTPOINT'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        return $minimyth->var_get('MM_MEDIA_GAME_MOUNTPOINT') . '/bios';
    }
};
$var_list{'MM_GAME_GAME_ROOT'} =
{
    prerequisite   => ['MM_MEDIA_GAME_MOUNTPOINT'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        return $minimyth->var_get('MM_MEDIA_GAME_MOUNTPOINT') . '/game';
    }
};

1;
