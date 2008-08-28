#!/usr/bin/perl
################################################################################
# MM_MASTER configuration variable handlers.
################################################################################
package init::conf::MM_MASTER;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_MASTER_SERVER'} =
{
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        return $minimyth->var_get('MM_TFTP_SERVER');
    }
};
$var_list{'MM_MASTER_DBUSERNAME'} =
{
    value_default  => 'mythtv'
};
$var_list{'MM_MASTER_DBPASSWORD'} =
{
    value_default  => 'mythtv'
};
$var_list{'MM_MASTER_DBNAME'} =
{
    value_default  => 'mythconverg'
};
$var_list{'MM_MASTER_WOL_ENABLED'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes'
};
$var_list{'MM_MASTER_WOL_MAC'} =
{
    value_default  => '00:00:00:00:00:00'
};
$var_list{'MM_MASTER_WOLSQLRECONNECTWAITTIME'} =
{
    value_default  => '15'
};
$var_list{'MM_MASTER_WOLSQLCONNECTRETRY'} =
{
    value_default  => '20'
};
$var_list{'MM_MASTER_WOLSQLCOMMAND'} =
{
    value_default  => 'wakelan -b @MM_MASTER_WOL_BROADCAST@ -m @MM_MASTER_WOL_MAC@'
};
$var_list{'MM_MASTER_WOL_ADDITIONAL_DELAY'} =
{
    value_default  => '0'
};

1;
