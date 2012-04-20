################################################################################
# MM_AIRPLAY configuration variable handlers.
################################################################################
package init::conf::MM_AIRPLAY;

use strict;
use warnings;
use feature "switch";

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_AIRPLAY_FETCH_RAOPKEY_RSA'} =
{
    prerequisite   => ['MM_VERSION_MYTH_BINARY_MINOR'],
    value_default  => 'no',
    value_valid    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        given ($minimyth->var_get('MM_VERSION_MYTH_BINARY_MINOR'))
        {
            when (/^(22|23|24)$/)
            {
                return 'no';
            }
            default
            {
                return 'yes|no';
            }
        }
    },
    value_file     => 'yes',
    file           => {name_remote => '/RAOPKey.rsa',
                       name_local  => '/home/minimyth/.mythtv/RAOPKey.rsa',
                       mode_local  => '0400'},
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        if (-e '/home/minimyth/.mythtv/RAOPKey.rsa')
        {
            $minimyth->file_replace_variable(
                '/etc/conf.d/core',
                { '@MYTHTV_AIRPLAY@' => '1' });
        }
        else
        {
            $minimyth->file_replace_variable(
                '/etc/conf.d/core',
                { '@MYTHTV_AIRPLAY@' => '0' });
        }
    }
};
