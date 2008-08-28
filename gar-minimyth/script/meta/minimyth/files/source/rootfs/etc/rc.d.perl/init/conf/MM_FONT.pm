#!/usr/bin/perl
################################################################################
# MM_FONT configuration variable handlers.
################################################################################
package init::conf::MM_FONT;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_FONT_FILE_TTF_DELETE'} =
{
    value_default  => '',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if ($minimyth->var_get($name))
        {
            my $font_match = join('|', split(/  +/, $minimyth->var_get($name)));
            $minimyth->var_set($name, '');
            if ((-d '/usr/lib/X11/fonts/TTF') && (opendir(DIR, '/usr/lib/X11/fonts/TTF')))
            {
                $minimyth->var_set($name, join(' ', (grep(/^$font_match$/ && -f "/usr/lib/X11/fonts/TTF/$_", (readdir(DIR))))));
                closedir(DIR);
            }
        }
    }
};
$var_list{'MM_FONT_FILE_TTF_ADD'} =
{
    value_default  => '',
    value_file     => '.+',
    file           => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @file;

        foreach (split(/ +/, $minimyth->var_get($name)))
        {
            s/\/\/+/\//g;
            s/^\///;

            my $item;
            $item->{'name_remote'} = "/$_";
            $item->{'name_local'}  = "/usr/lib/X11/fonts/TTF/$_";
            $item->{'mode_local'}  = '644';

            push(@file, $item);
        }

        return \@file;
    }
};

1;
