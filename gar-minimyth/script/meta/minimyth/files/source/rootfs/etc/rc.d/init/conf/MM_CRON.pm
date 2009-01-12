################################################################################
# MM_CRON configuration variable handlers.
################################################################################
package init::conf::MM_CRON;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_CRON_FETCH_CRONTAB'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {name_remote => '/crontab',
                       name_local  => '/var/spool/cron/crontabs/root'}
};

1;
