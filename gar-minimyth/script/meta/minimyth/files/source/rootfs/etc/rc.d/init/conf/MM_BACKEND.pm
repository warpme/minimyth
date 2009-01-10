#!/usr/bin/perl
################################################################################
# MM_BACKEND configuration variable handlers.
################################################################################
package init::conf::MM_BACKEND;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_BACKEND_ENABLED'} =
{
    value_default => 'auto',
    value_valid   => 'auto|no|yes',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $backend = $minimyth->detect_state_get('backend', 0, 'enabled');
        if ((defined $backend) && ($backend eq 'yes'))
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    }
};

$var_list{'MM_BACKEND_TUNER_FIRMWARE_FILE_LIST'} =
{
    value_default => 'auto',
    value_valid   => 'auto|none|.*',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @value_auto = ();

        my @tuners = @{$minimyth->detect_state_get('tuner')};
        foreach my $tuner (@tuners)
        {
            push(@value_auto, split(/:/, $tuner->{firmware}));
        }

        # Remove any dumplicates.
        {
            my $prev = '';
            @value_auto = grep($_ ne $prev && (($prev) = $_), sort(@value_auto));
        }

        return join(' ', @value_auto);
    },
    value_none    => '',
    value_file    => '.+',
    file          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @file = ();

        foreach (split(/ /, $minimyth->var_get($name)))
        {
            my $item;
            $item->{'name_remote'} = "$_";
            $item->{'name_local'}  = '/lib/firmware/' . File::Basename::basename($_);
            $item->{'mode_local'}  = '0644';

            push(@file, $item);
        }

        return \@file;
    }
};

1;
