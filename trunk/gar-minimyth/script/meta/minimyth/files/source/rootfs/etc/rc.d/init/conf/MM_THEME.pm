#!/usr/bin/perl
################################################################################
# MM_THEME configuration variable handlers.
################################################################################
package init::conf::MM_THEME;

use strict;
use warnings;

require File::Basename;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_THEMECACHE_URL'} =
{
    prerequisite   => ['MM_MASTER_.*', 'MM_THEME_NAME', 'MM_X_MODE'],
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_obsolete => 'default',
    value_auto     => 'confrw:themecache.sfs',
    value_none     => ''
};
$var_list{'MM_THEME_NAME'} =
{
    value_default  => '',
    value_valid    => '.+',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;
  
        if ($minimyth->var_get($name) eq 'G.A.N.T.')
        {
            $minimyth->message_output('err', "error: theme 'G.A.N.T.' has been renamed to 'G.A.N.T'. Please update '$name'.");
        }
    }
};
$var_list{'MM_THEME_URL'} =
{
    prerequisite   => ['MM_THEME_NAME'],
    value_default  => 'auto',
    value_valid    => sub
    {
        my $minimyth = shift;
        my $name     = shift;
  
        if ($minimyth->var_get($name) !~ /^auto|none$/)
        {
            my $theme_name = $minimyth->var_get('MM_THEME_NAME');
            if (-e "/usr/share/mythtv/themes/$theme_name")
            {
                $minimyth->message_output('err', "error: MythTV theme directory '$theme_name' already exists.");
                return '';
            }
        }
        if ($minimyth->var_get($name) eq 'none')
        {
            my $theme_name = $minimyth->var_get('MM_THEME_NAME');
            if (! -e "/usr/share/mythtv/themes/$theme_name")
            {
                $minimyth->message_output('err', "error: MythTV theme directory '$theme_name' does not exist.");
                return '';
            }
        }
        return '.+';
    },
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;
  
        my $theme_name = $minimyth->var_get('MM_THEME_NAME');
        if (! -e "/usr/share/mythtv/themes/$theme_name")
        {
            return "hunt:themes/$theme_name.sfs"
        }
        else
        {
            return 'none';
        }
    },
    value_none     => ''
};
$var_list{'MM_THEMEOSD_NAME'} =
{
    value_default  => '',
    value_valid    => '.+',
};
$var_list{'MM_THEMEOSD_URL'} =
{
    prerequisite   => ['MM_THEMEOSD_NAME'],
    value_default  => 'auto',
    value_valid    => sub
    {
        my $minimyth = shift;
        my $name     = shift;
  
        if ($minimyth->var_get($name) !~ /^auto|none$/)
        {
            my $themeosd_name = $minimyth->var_get('MM_THEMEOSD_NAME');
            if (-e "/usr/share/mythtv/themes/$themeosd_name")
            {
                $minimyth->message_output('err', "error: MythTV theme directory '$themeosd_name' already exists.");
                return '';
            }
        }
        if ($minimyth->var_get($name) eq 'none')
        {
            my $themeosd_name = $minimyth->var_get('MM_THEMEOSD_NAME');
            if (! -e "/usr/share/mythtv/themes/$themeosd_name")
            {
                $minimyth->message_output('err', "error: MythTV theme directory '$themeosd_name' does not exist.");
                return '';
            }
        }
        return '.+';
    },
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;
  
        my $themeosd_name = $minimyth->var_get('MM_THEMEOSD_NAME');
        if (! -e "/usr/share/mythtv/themes/$themeosd_name")
        {
            return "hunt:themes/$themeosd_name.sfs"
        }
        else
        {
            return 'none';
        }
    },
    value_none     => ''
};
$var_list{'MM_THEME_FILE_MENU_ADD'} =
{
    value_default  => '',
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
            $item->{'name_local'}  = '/home/minimyth/.mythtv/' . File::Basename::basename($_);
            $item->{'mode_local'}  = '0644';

            push(@file, $item);
        }

        return \@file;
    }
};

1;
