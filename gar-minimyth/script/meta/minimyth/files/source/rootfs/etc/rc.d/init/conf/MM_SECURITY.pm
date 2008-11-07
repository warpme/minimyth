#!/usr/bin/perl
################################################################################
# MM_SECURITY configuration variable handlers.
################################################################################
package init::conf::MM_SECURITY;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_SECURITY_ENABLED'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes'
};
$var_list{'MM_SECURITY_USER_MINIMYTH_UID'} =
{
    value_default  => '1000',
    value_valid    => '[0-9]+'
};
$var_list{'MM_SECURITY_USER_MINIMYTH_GID'} =
{
    value_default  => '1000',
    value_valid    => '[0-9]+'
};
$var_list{'MM_SECURITY_FETCH_CA_BUNDLE_CRT'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {name_remote => '/ca-bundle.crt',
                       name_local  => '/etc/ssl/certs/ca-bundle.crt'}
};
$var_list{'MM_SECURITY_FETCH_CREDENTIALS_CIFS'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {name_remote => '/credentials_cifs',
                       name_local  => '/etc/cifs/credentials_cifs',
                       mode_local  => '0600'}
};

1;
