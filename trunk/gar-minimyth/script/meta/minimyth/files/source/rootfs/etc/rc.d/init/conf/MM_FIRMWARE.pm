################################################################################
# MM_FIRMWARE configuration variable handlers.
################################################################################
package init::conf::MM_FIRMWARE;

use strict;
use warnings;

use File::Basename ();

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_FIRMWARE_FILE_LIST'} =
{
    value_default => 'auto',
    value_valid   => 'auto|none|.*',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @value_auto = ();

        my @firmwares = @{$minimyth->detect_state_get('firmware')};
        foreach my $firmware (@firmwares)
        {
            push(@value_auto, split(/:/, $firmware->{file_list}));
        }

        # Remove any duplicates.
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

        foreach my $name_remote (split(/ /, $minimyth->var_get($name)))
        {
            my $name_local = '/lib/firmware/' . File::Basename::basename($name_remote);
            # Fetch firmware files that are not already present.
            if (! -e $name_local)
            {
                my $item;
                $item->{'name_remote'} = $name_remote;
                $item->{'name_local'}  = $name_local;
                $item->{'mode_local'}  = '0644';

                push(@file, $item);
            }
        }

        return \@file;
    }
};

1;
