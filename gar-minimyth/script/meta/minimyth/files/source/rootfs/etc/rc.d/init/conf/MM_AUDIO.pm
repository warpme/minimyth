################################################################################
# MM_AUDIO configuration variable handlers.
################################################################################
package init::conf::MM_AUDIO;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_AUDIO_TYPE'} =
{
    value_default => 'analog',
    value_valid   => 'analog|digital|digital\+analog',
};
$var_list{'MM_AUDIO_CARD_NUMBER'} =
{
    value_default => 'auto',
    value_valid   => 'auto|.+',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value = $minimyth->detect_state_get('audio', 0, 'card_number');
        if (! defined $value)
        {
            $minimyth->message_log('warn', qq('unknown audio card. assuming audio card number is '0'.));
            $value = '0';
        }
        return $value;
    }
};
$var_list{'MM_AUDIO_DEVICE_NUMBER'} =
{
    value_default => 'auto',
    value_valid   => 'auto|.+',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value = $minimyth->detect_state_get('audio', 0, 'device_number');
        if (! defined $value)
        {
            $minimyth->message_log('warn', qq('unknown audio device. assuming audio device number is '0'.));
            $value = '0';
        }
        return $value;
    }
};

$var_list{'MM_AUDIO_GAIN'} =
{
    value_default => 'auto',
    value_valid   => 'auto|[0-9]+',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value = $minimyth->detect_state_get('audio', 0, 'gain');
        if (! defined $value)
        {
            $minimyth->message_log('warn', qq('unknown audio device. assuming audio gain is '90'.));
            $value = '90';
        }
        return $value;
    }
};

$var_list{'MM_AUDIO_FETCH_ASOUND_CONF'} =
{
    value_default => 'no',
    value_valid   => 'no|yes',
    value_file    => 'yes',
    file          => {name_remote => '/asound.conf',
                      name_local  => '/etc/asound.conf'}
};

$var_list{'MM_AUDIO_FETCH_ASOUND_STATE'} =
{
    value_default => 'no',
    value_valid   => 'no|yes',
    value_file    => 'yes',
    file          => {name_remote => '/asound.state',
                      name_local  => '/etc/asound.state'}
};

1;
