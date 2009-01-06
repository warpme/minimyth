#!/usr/bin/perl
################################################################################
# MM_FONT configuration variable handlers.
################################################################################
package init::conf::MM_FONT;

use strict;
use warnings;

use File::Basename ();

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
    value_clean    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean = " $value_clean ";
        $value_clean =~ s/[ \t]+/ /g;
        $value_clean =~ s/ ([^ \/])/ \/$1/g;
        $value_clean =~ s/\/+/\//g;
        $value_clean =~ s/^ //;
        $value_clean =~ s/ $//;
        $minimyth->var_set($name, $value_clean);
    },
    value_default  => '',
    value_file     => '.+',
    file           => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @file = ();

        foreach (split(/ /, $minimyth->var_get($name)))
        {
            my $item;
            $item->{'name_remote'} = "$_";
            $item->{'name_local'}  = '/usr/lib/X11/fonts/TTF/' . File::Basename::basename($_);
            $item->{'mode_local'}  = '0644';

            push(@file, $item);
        }

        return \@file;
    }
};

1;
