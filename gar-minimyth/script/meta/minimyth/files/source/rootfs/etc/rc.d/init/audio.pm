################################################################################
# audio
################################################################################
package init::audio;

use strict;
use warnings;
use feature "switch";

use File::Spec ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $card_number   = $minimyth->var_get('MM_AUDIO_CARD_NUMBER');
    my $device_number = $minimyth->var_get('MM_AUDIO_DEVICE_NUMBER');
    my $type          = $minimyth->var_get('MM_AUDIO_TYPE');

    my $devnull = File::Spec->devnull;

    my $amixer_command = "/usr/bin/amixer -c $card_number";

    $minimyth->message_output('info', "configuring audio ...");

    # Set audio card number and audio card device.
    $minimyth->file_replace_variable(
        '/etc/asound.conf',
        { '@MM_AUDIO_CARD_NUMBER@'   => $card_number,
          '@MM_AUDIO_DEVICE_NUMBER@' => $device_number });
    
    # Wait for audio driver to load.
    my $timeout = 10;
    while ((system(qq($amixer_command > $devnull 2>&1)) != 0) && ($timeout > 0))
    {
        sleep(1);
        $timeout--;
    }
    if (system(qq($amixer_command > $devnull 2>&1)) != 0)
    {
        $minimyth->message_output('err', "the audio driver does not appear to be loaded.");
        return 0;
    }

    # Configure Xine audio.
    if ($type =~ /^(.*\+)?digital(\+.*)?$/)
    {
        $minimyth->file_replace_variable(
            '/home/minimyth/.xine/config',
            { '@SPEAKER_ARRANGEMENT@' => 'Pass Through' });
    }
    if ($type =~ /^(.*\+)?analog(\+.*)?$/)
    {
        $minimyth->file_replace_variable(
            '/home/minimyth/.xine/config',
            { '@SPEAKER_ARRANGEMENT@' => 'Stereo 2.0' });
    }

    # Unmute audio.
    if (system(qq($amixer_command > $devnull 2>&1)) == 0)
    {
        if ((-e qq(/usr/sbin/alsactl)) && (-e q(/etc/asound.state)))
        {
            system(qq(/usr/sbin/alsactl -f /etc/asound.state restore));
        }
        else
        {
            my $gain = $minimyth->var_get('MM_AUDIO_GAIN') . '%';
            if ($type =~ /^(.*\+)?analog(\+.*)?$/)
            {
                if (open(FILE, '-|', "$amixer_command scontrols"))
                {
                    foreach (grep(s/^Simple mixer control '([^']*)'(,[0-9]+)?$/$1/, (<FILE>)))
                    {
                        given ($_)
                        {
                            # General unmuting.
                            when (/^PCM$/)                { system(qq($amixer_command sset 'PCM'                       $gain unmute)); }
                            when (/^Master$/)             { system(qq($amixer_command sset 'Master'                    $gain unmute)); }
                            when (/^Front$/)              { system(qq($amixer_command sset 'Front'                     $gain unmute)); }
                            when (/^Master Front$/)       { system(qq($amixer_command sset 'Master Front'              $gain unmute)); }
                            when (/^Analog Front$/)       { system(qq($amixer_command sset 'Analog Front'              $gain unmute)); }
                            when (/^Surround$/)           { system(qq($amixer_command sset 'Surround'                  $gain unmute)); }
                            when (/^Analog Side$/)        { system(qq($amixer_command sset 'Analog Side'               $gain unmute)); }
                            when (/^Analog Rear$/)        { system(qq($amixer_command sset 'Analog Rear'               $gain unmute)); }
                            when (/^Center$/)             { system(qq($amixer_command sset 'Center'                    $gain unmute)); }
                            when (/^LFE$/)                { system(qq($amixer_command sset 'LFE'                       $gain unmute)); }
                            when (/^Analog Center\/LFE$/) { system(qq($amixer_command sset 'Analog Center/LFE'         $gain unmute)); }
                            # VIA Specific unmuting.
                            when (/^VIA DXS$/)            { system(qq($amixer_command sset 'VIA DXS'                   100%      )); }
                        }
                    }
                    close(FILE);
                }
            }
            if ($type =~ /^(.*\+)?digital(\+.*)?$/)
            {
                if (open(FILE, '-|', "$amixer_command scontrols"))
                {
                    foreach (grep(s/^Simple mixer control '([^']*)'(,[0-9]+)?$/$1/, (<FILE>)))
                    {
                        given ($_)
                        {
                            # General unmuting.
                            when (/^IEC958$/)             { system(qq($amixer_command sset 'IEC958'                    on        )); }
                            when (/^IEC958 Front$/)       { system(qq($amixer_command sset 'IEC958 Front'              $gain unmute)); }
                            when (/^IEC958 Side$/)        { system(qq($amixer_command sset 'IEC958 Side'               $gain unmute)); }
                            when (/^IEC958 Rear$/)        { system(qq($amixer_command sset 'IEC958 Rear'               $gain unmute)); }
                            when (/^IEC958 Center\/LFE$/) { system(qq($amixer_command sset 'IEC958 Center/LFE'         $gain unmute)); }
                            # VIA Specific unmuting.
                            when (/^IEC958 Playback AC97-SPSA$/)
                                                          { system(qq($amixer_command sset 'IEC958 Playback AC97-SPSA' 0         )); }
                        }
                    }
                    close(FILE);
                }
            }
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    my $card_number   = $minimyth->var_get('MM_AUDIO_CARD_NUMBER');
    my $device_number = $minimyth->var_get('MM_AUDIO_DEVICE_NUMBER');
    my $type          = $minimyth->var_get('MM_AUDIO_TYPE');

    my $devnull       = File::Spec->devnull;

    my $amixer_command = "/usr/bin/amixer -c $card_number";

    $minimyth->message_output('info', "muting audio ...");

    # Mute audio.
    if (system(qq($amixer_command > $devnull 2>&1)) == 0)
    {
        if ($type =~ /^(.*\+)?analog(\+.*)?$/)
        {
            if (open(FILE, '-|', "$amixer_command scontrols"))
            {
                foreach (grep(s/^Simple mixer control '([^']*)'(,[0-9]+)?$/$1/, (<FILE>)))
                {
                    given ($_)
                    {
                        # General muting.
                        when (/^PCM$/)                { system(qq($amixer_command set 'PCM'               0% mute)); }
                        when (/^Master$/)             { system(qq($amixer_command set 'Master'            0% mute)); }
                        when (/^Front$/)              { system(qq($amixer_command set 'Front'             0% mute)); }
                        when (/^Analog Front$/)       { system(qq($amixer_command set 'Analog Front'      0% mute)); }
                        when (/^Surround$/)           { system(qq($amixer_command set 'Surround'          0% mute)); }
                        when (/^Analog Side$/)        { system(qq($amixer_command set 'Analog Sied'       0% mute)); }
                        when (/^Analog Rear$/)        { system(qq($amixer_command set 'Analog Rear'       0% mute)); }
                        when (/^Center$/)             { system(qq($amixer_command set 'Center'            0% mute)); }
                        when (/^LFE$/)                { system(qq($amixer_command set 'LFE'               0% mute)); }
                        when (/^Analog Center\/LFE$/) { system(qq($amixer_command set 'Analog Center/LFE' 0% mute)); }
                        # VIA Specific muting.
                        when (/^VIA DXS$/)            { system(qq($amixer_command set 'VIA DXS'           0%     )); }
                        when (/^IEC958 Center\/LFE$/) { system(qq($amixer_command set 'IEC958 Center/LFE' 0% mute)); }
                    }
                }
                close(FILE);
            }
        }
        if ($type =~ /^(.*\+)?digital(\+.*)?$/)
        {
            if (open(FILE, '-|', "$amixer_command scontrols"))
            {
                foreach (grep(s/^Simple mixer control '([^']*)'(,[0-9]+)?$/$1/, (<FILE>)))
                {
                    given ($_)
                    {
                        # General unmuting.
                        when (/^IEC958$/)             { system(qq($amixer_command set 'IEC958'            off    )); }
                        when (/^IEC958 Front$/)       { system(qq($amixer_command set 'IEC958 Front'      0% mute)); }
                        when (/^IEC958 Side$/)        { system(qq($amixer_command set 'IEC958 Side'       0% mute)); }
                        when (/^IEC958 Rear$/)        { system(qq($amixer_command set 'IEC958 Rear'       0% mute)); }
                        when (/^IEC958 Center\/LFE$/) { system(qq($amixer_command set 'IEC958 Center/LFE' 0% mute)); }
                    }
                }
                close(FILE);
            }
        }
    }

    return 1;
}

1;
