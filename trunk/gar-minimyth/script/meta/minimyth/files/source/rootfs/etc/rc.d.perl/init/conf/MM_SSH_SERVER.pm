#!/usr/bin/perl
################################################################################
# MM_SSH_SERVER configuration variable handlers.
################################################################################
package init::conf::MM_SSH_SERVER;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_SSH_SERVER_ENABLED'} =
{
    prerequisite   => ['MM_SECURITY_ENABLED'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        # The routine relies on MM_SECURITY_ENABLED.
        if ($minimyth->var_get('MM_SECURITY_ENABLED') eq 'yes')
        {
            return 'yes';
        }
        else
        {
            return 'no';
        }
    },
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @file;

        $file[0]->{'name_remote'} = '/ssh_host_rsa_key';
        $file[0]->{'name_local'}  = '/etc/ssh/ssh_host_rsa_key';
        $file[0]->{'mode_local'}  = '600';

        $file[1]->{'name_remote'} = '/authorized_keys';
        $file[1]->{'name_local'}  = '/etc/ssh/authorized_keys';
        $file[1]->{'mode_local'}  = '600';

        return \@file;
    }
};

1;
