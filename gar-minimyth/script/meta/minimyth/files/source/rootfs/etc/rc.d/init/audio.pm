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
                    foreach (grep(s/^Simple mixer control ('[^']*'(,[0-9]+)?)$/$1/, (<FILE>)))
                    {
                        chomp;
                        given ($_)
                        {
                            # General unmuting.
                            when (m!^'PCM'!)                { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Master'!)             { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Speaker'!)            { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Front'!)              { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Analog Front'!)       { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Master Front'!)       { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Center'!)             { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'LFE'!)                { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Side'!)               { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Analog Side'!)        { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Surround'!)           { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Analog Rear'!)        { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'Analog Center/LFE'!)  { system(qq($amixer_command sset $_ $gain unmute)); }
                            # VIA Specific unmuting.
                            when (m!^'VIA DXS'!)            { system(qq($amixer_command sset $_ 100%        )); }
                        }
                    }
                    close(FILE);
                }
            }
            if ($type =~ /^(.*\+)?digital(\+.*)?$/)
            {
                if (open(FILE, '-|', "$amixer_command scontrols"))
                {
                    foreach (grep(s/^Simple mixer control ('[^']*'(,[0-9]+)?)$/$1/, (<FILE>)))
                    {
                        chomp;
                        given ($_)
                        {
                            # General unmuting.
                            when (m!^'IEC958'!)             { system(qq($amixer_command sset $_ on          )); }
                            when (m!^'IEC958 Default PCM'!) { system(qq($amixer_command sset $_ on          )); }
                            when (m!^'IEC958 Front'!)       { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'IEC958 Center/LFE'!)  { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'IEC958 Side'!)        { system(qq($amixer_command sset $_ $gain unmute)); }
                            when (m!^'IEC958 Rear'!)        { system(qq($amixer_command sset $_ $gain unmute)); }
                            # VIA Specific unmuting.
                            when (m!^'IEC958 Playback AC97-SPSA'!)
                                                            { system(qq($amixer_command sset $_ 0           )); }
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
                foreach (grep(s/^Simple mixer control ('[^']*'(,[0-9]+)?)$/$1/, (<FILE>)))
                {
                    chomp;
                    given ($_)
                    {
                        # General muting.
                        when (m!^'PCM'!)                { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Master'!)             { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Speaker'!)            { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Front'!)              { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Analog Front'!)       { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Master Front'!)       { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Center'!)             { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'LFE'!)                { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Side'!)               { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Analog Side'!)        { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Surround'!)           { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Analog Rear'!)        { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'Analog Center/LFE'!)  { system(qq($amixer_command sset $_ 0% mute)); }
                        # VIA Specific muting.
                        when (m!^'VIA DXS'!)            { system(qq($amixer_command sset $_ 0%     )); }
                    }
                }
                close(FILE);
            }
        }
        if ($type =~ /^(.*\+)?digital(\+.*)?$/)
        {
            if (open(FILE, '-|', "$amixer_command scontrols"))
            {
                foreach (grep(s/^Simple mixer control ('[^']*'(,[0-9]+)?)$/$1/, (<FILE>)))
                {
                    chomp;
                    given ($_)
                    {
                        # General muting.
                        when (m!^'IEC958'!)             { system(qq($amixer_command sset $_ off    )); }
                        when (m!^'IEC958 Default PCM'!) { system(qq($amixer_command sset $_ off    )); }
                        when (m!^'IEC958 Front'!)       { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'IEC958 Center/LFE'!)  { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'IEC958 Side'!)        { system(qq($amixer_command sset $_ 0% mute)); }
                        when (m!^'IEC958 Rear'!)        { system(qq($amixer_command sset $_ 0% mute)); }
                    }
                }
                close(FILE);
            }
        }
    }

    return 1;
}

1;
