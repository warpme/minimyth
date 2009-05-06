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

$var_list{'MM_BACKEND_DEBUG_LEVEL'} =
{
    prerequisite  => ['MM_DEBUG'],
    value_default => sub
    {
        my $minimyth = shift;
        my $name     = shift;
  
        if ($minimyth->var_get('MM_DEBUG') eq 'yes')
        {
            return 'all';
        }
        else
        {
            return 'none';
        }
    },
    value_valid   => 'none|most|all|[[:alnum:],]+'
};

1;
