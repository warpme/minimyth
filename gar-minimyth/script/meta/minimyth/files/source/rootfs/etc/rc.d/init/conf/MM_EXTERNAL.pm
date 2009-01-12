################################################################################
# MM_EXTERNAL configuration variable handlers.
################################################################################
package init::conf::MM_EXTERNAL;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_EXTERNAL_POWER_OFF'} =
{
};
$var_list{'MM_EXTERNAL_POWER_ON'} =
{
};
$var_list{'MM_EXTERNAL_VOLUME_DOWN'} =
{
};
$var_list{'MM_EXTERNAL_VOLUME_UP'} =
{
    prerequisite   => ['MM_EXTERNAL_VOLUME_DOWN'],
    extra          => sub
    {
        my $minimyth = shift;

        if ((  $minimyth->var_get('MM_EXTERNAL_VOLUME_UP')) && (! $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_UP is set but MM_EXTERNAL_VOLUME_DOWN is not set.");
        }
        if ((! $minimyth->var_get('MM_EXTERNAL_VOLUME_UP')) && (  $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_UP is not set but MM_EXTERNAL_VOLUME_DOWN is set.");
        }
    }
};
$var_list{'MM_EXTERNAL_VOLUME_MUTE'} =
{
    prerequisite   => ['MM_EXTERNAL_VOLUME_DOWN', 'MM_EXTERNAL_VOLUME_UP'],
    extra          => sub
    {
        my $minimyth = shift;

        if ((  $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (! $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is set but MM_EXTERNAL_VOLUME_DOWN is not set.");
        }
        if ((  $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (! $minimyth->var_get('MM_EXTERNAL_VOLUME_UP'  )))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is set but MM_EXTERNAL_VOLUME_UP is not set.");
        }
        if ((! $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (  $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is not set but MM_EXTERNAL_VOLUME_DOWN is set.");
        }
        if ((! $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')) && (  $minimyth->var_get('MM_EXTERNAL_VOLUME_UP'  )))
        {
            $minimyth->message_output('err', "MM_EXTERNAL_VOLUME_MUTE is not set but MM_EXTERNAL_VOLUME_UP is set.");
        }
    }
};
$var_list{'MM_EXTERNAL_VOLUME_ENABLED'} =
{
    prerequisite   => ['MM_EXTERNAL_VOLUME_DOWN', 'MM_EXTERNAL_VOLUME_UP', 'MM_EXTERNAL_VOLUME_MUTE'],
    value_default  => sub
    {
        my $minimyth = shift;

        if ((! $minimyth->var_get('MM_EXTERNAL_VOLUME_DOWN')) &&
            (! $minimyth->var_get('MM_EXTERNAL_VOLUME_UP'  )) &&
            (! $minimyth->var_get('MM_EXTERNAL_VOLUME_MUTE')))
        {
            return 'no';
        }
        else
        {
            return 'yes';
        }
    },
    value_valid   => 'no|yes'
};

1;
