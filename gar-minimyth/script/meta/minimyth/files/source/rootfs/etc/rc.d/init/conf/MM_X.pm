################################################################################
# MM_X configuration variable handlers.
################################################################################
package init::conf::MM_X;

use strict;
use warnings;
use feature "switch";

my %var_list;

sub var_list
{
    return \%var_list;
}

#===============================================================================
#
#===============================================================================
$var_list{'MM_X_DRIVER'} =
{
    value_default => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        return $minimyth->detect_state_get('video', 0, 'driver');
    },
    value_valid   => '.+'
};
#===============================================================================
#
#===============================================================================
$var_list{'MM_X_ENABLED'} =
{
    value_default => 'yes',
    value_valid   => 'no|yes'
};
$var_list{'MM_X_RESTART_ON_SLEEP_ENABLED'} =
{
    value_default => 'no',
    value_valid   => 'no|yes'
};
$var_list{'MM_X_WM_ENABLED'} =
{
    value_default => 'yes',
    value_valid   => 'no|yes'
};
$var_list{'MM_X_VNC_ENABLED'} =
{
    value_default => 'yes',
    value_valid   => 'no|yes'
};
$var_list{'MM_X_SCREENSAVER'} =
{
    value_default => 'none',
    value_valid   => 'none|xorg|xscreensaver'
};
$var_list{'MM_X_SCREENSAVER_TIMEOUT'} =
{
    value_default => '2',
    value_valid   => '[0-9]+'
};
$var_list{'MM_X_SCREENSAVER_HACK'} =
{
    value_default => 'blank',
    value_valid   => 'sleep|blank|glslideshow'
};
$var_list{'MM_X_MYTH_PROGRAM'} =
{
    value_default => 'mythfrontend',
    value_valid   => 'mythfrontend|mythwelcome'
};
#===============================================================================
#
#===============================================================================
$var_list{'MM_X_HACK_HIDE_BLUE_LINE_ENABLED'} =
{
    value_default => 'no',
    value_valid   => 'no|yes'
};
#===============================================================================
#
#===============================================================================
$var_list{'MM_X_FETCH_XINITRC'} =
{
    value_default => 'no',
    value_valid   => 'no|yes',
    value_file    => 'yes',
    file          => {name_remote => '/xinitrc',
                      name_local  => '/etc/X11/xinit/xinitrc'}
};
$var_list{'MM_X_FETCH_XMODMAPRC'} =
{
    value_default => 'no',
    value_valid   => 'no|yes',
    value_file    => 'yes',
    file          => {name_remote => '/xmodmaprc',
                      name_local  => '/etc/X11/xmodmaprc'}
};
$var_list{'MM_X_FETCH_XORG_CONF'} =
{
    value_default => 'no',
    value_valid   => 'no|yes',
    value_file    => 'yes',
    file          => {name_remote => '/xorg.conf',
                      name_local  => '/etc/X11/xorg.conf'}
};
#===============================================================================
#
#===============================================================================
$var_list{'MM_X_OUTPUT_DVI'} =
{
    value_default => 'none',
    value_valid   => 'none|auto|[0-9]+'
};
$var_list{'MM_X_OUTPUT_VGA'} =
{
    value_default => 'none',
    value_valid   => 'none|auto|[0-9]+'
};
$var_list{'MM_X_OUTPUT_TV'} =
{
    prerequisite  => ['MM_X_DRIVER', 'MM_X_OUTPUT_DVI', 'MM_X_OUTPUT_VGA'],
    value_default => 'none',
    value_valid   => 'none|auto|[0-9]+',
    extra         => sub
    {
        my $minimyth = shift;
        my $name     = shift;
        
        my $success = 1;
        if (($minimyth->var_get('MM_X_OUTPUT_DVI') eq 'none') &&
            ($minimyth->var_get('MM_X_OUTPUT_VGA') eq 'none') &&
            ($minimyth->var_get('MM_X_OUTPUT_TV')  eq 'none'))
        {
            $minimyth->message_output('err', qq('MM_X_OUTPUT_DVI', 'MM_X_OUTPUT_VGA' and 'MM_X_OUTPUT_TV' are all disabled.));
        }
        if ($minimyth->var_get('MM_X_DRIVER') eq 'nvidia')
        {
            # Make sure no more than one output is enabled.
            if ((! $minimyth->var_get('MM_X_OUTPUT_DVI') eq 'none') &&
                (! $minimyth->var_get('MM_X_OUTPUT_VGA') eq 'none'))
            {
                $minimyth->message_output('err', qq('MM_X_OUTPUT_DVI' and 'MM_X_OUTPUT_VGA' are both enabled.));
                $success = 0;
            }
            if ((! $minimyth->var_get('MM_X_OUTPUT_DVI') eq 'none') &&
                (! $minimyth->var_get('MM_X_OUTPUT_TV')  eq 'none'))
            {
                $minimyth->message_output('err', qq('MM_X_OUTPUT_DVI' and 'MM_X_OUTPUT_TV' are both enabled.));
                $success = 0;
            }
            if ((! $minimyth->var_get('MM_X_OUTPUT_VGA') eq 'none') &&
                (! $minimyth->var_get('MM_X_OUTPUT_TV')  eq 'none'))
            {
                $minimyth->message_output('err', qq('MM_X_OUTPUT_VGA' and 'MM_X_OUTPUT_TV' are both enabled.));
                $success = 0;
            }
        }
        if ($minimyth->var_get('MM_X_DRIVER') eq 'openchrome')
        {
            # Make sure that DVI and TV outputs are not enabled at the same time.
            if ((! $minimyth->var_get('MM_X_OUTPUT_DVI') eq 'none') &&
                (! $minimyth->var_get('MM_X_OUTPUT_TV')  eq 'none'))
            {
                $minimyth->message_output('err', qq('MM_X_OUTPUT_DVI' and 'MM_X_OUTPUT_TV' are both enabled.));
                $success = 0;
            }
        }
        return $success;
    }
};
#===============================================================================
#
#===============================================================================
$var_list{'MM_X_SYNC'} =
{
    value_default => 'auto',
    value_valid   => 'auto|(HorizSync )?[0-9]+([.][0-9]*)?(-[0-9]+([.][0-9]*)?)?(,[0-9]+([.][0-9]*)?(-[0-9]+([.][0-9]*)?)?)*',
    value_auto    => '10.0-70.0',
    extra         => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value = $minimyth->var_get($name);

        if ($value =~ /^HorizSync (.*)$/)
        {
            $value = $1;
        }

        if ($value =~ /^([0-9]+([.][0-9]*)?)$/)
        {
            my $lower = $1 - 1;
            my $upper = $1 + 1;
            $value = $lower . '-' . $upper;
        }

        $value = 'HorizSync ' . $value;

        $minimyth->var_set($name, $value);

        return 1;
    }
};
$var_list{'MM_X_REFRESH'} =
{
    prerequisite  => ['MM_VIDEO_ASPECT_RATIO' , 'MM_VIDEO_RESIZE_ENABLED' , 'MM_X_OUTPUT_DVI', 'MM_X_OUTPUT_TV', 'MM_X_OUTPUT_VGA', 'MM_X_RESOLUTION' , 'MM_X_TV_TYPE'],
    value_default => 'auto',
    value_valid   => 'auto|(VertRefresh )?[0-9]+([.][0-9]*)?(-[0-9]+([.][0-9]*)?)?(,[0-9]+([.][0-9]*)?(-[0-9]+([.][0-9]*)?)?)*',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto;

        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_VIDEO_RESIZE_ENABLED') eq 'yes')
            {
                given ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO'))
                {
                    when (/^4:3$/)
                    {
                    }
                    when (/^16:9$/)
                    {
                        given ($minimyth->var_get('MM_X_TV_TYPE'))
                        {
                            when (/^NTSC(-(J|M))?$/)                { $value_auto = '58.0-62.0,118.0-122.0'; }
                            when (/^PAL(-(B|D|G|H|I|K1|M|N|NC))?$/) {}
                            when (/^(HD|hd)?480(I|i|P|p)$/)         { $value_auto = '58.0-62.0,118.0-122.0'; }
                            when (/^(HD|hd)?720(P|p)$/)             { $value_auto = '58.0-62.0,118.0-122.0'; }
                            when (/^(HD|hd)?1080(I|i|P|p)$/)        { $value_auto = '58.0-62.0,118.0-122.0'; }
                            when (/^(HD|hd)?576(I|i|P|p)$/)         {}
                        }
                    }
                    when (/^16:10$/)
                    {
                    }
                }
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_OUTPUT_DVI') ne 'none')
            {
                $value_auto = '60.0';
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_OUTPUT_VGA') ne 'none')
            {
                $value_auto = '60.0';
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_OUTPUT_TV') ne 'none')
            {
                given ($minimyth->var_get('MM_X_TV_TYPE'))
                {
                    when (/^NTSC(-(J|M))?$/)                { $value_auto = '60.0'; }
                    when (/^PAL(-(B|D|G|H|I|K1|M|N|NC))?$/) { $value_auto = '50.0'; }
                    when (/^(HD|hd)?480(I|i|P|p)$/)         { $value_auto = '60.0'; }
                    when (/^(HD|hd)?720(P|p)$/)             { $value_auto = '60.0'; }
                    when (/^(HD|hd)?1080(I|i|P|p)$/)        { $value_auto = '60.0'; }
                    when (/^(HD|hd)?576(I|i|P|p)$/)         { $value_auto = '50.0'; }
                }
            }
        }

        return $value_auto;
    },
    extra         => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value = $minimyth->var_get($name);

        if ($value =~ /^VertRefresh (.*)$/)
        {
            $value = $1;
        }

        if ($value =~ /^([0-9]+([.][0-9]*)?)$/)
        {
            my $lower = $1 - 2;
            my $upper = $1 + 2;
            $value = $lower . '-' . $upper;
        }

        $value = 'VertRefresh ' . $value;

        $minimyth->var_set($name, $value);

        return 1;
    }
};
$var_list{'MM_X_RESOLUTION'} =
{
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/^([0-9]+)[Xx]([0-9]+)$/$1x$2/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'none',
    value_valid   => 'none|[0-9]+x[0-9]+',
    value_none    => ''
};
$var_list{'MM_X_MODELINE'} =
{
    prerequisite  => ['MM_X_REFRESH', 'MM_X_RESOLUTION'],
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/  +/ /g;
        $value_clean =~ s/^[Mm][Oo][Dd][Ee][Ll][Ii][Nn][Ee] "([0-9]+)[Xx]([0-9]+)([^"]*)" (.*)$/Modeline "$1x$2$3" $4/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'auto',
    value_valid   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        # If the resolution is set, then the resolution in the modeline name must match the resolution set.
        my $value_valid;
        if ($minimyth->var_get('MM_X_RESOLUTION'))
        {
            $value_valid = 'Modeline "' . $minimyth->var_get('MM_X_RESOLUTION') . '[^"]*" .*';
            $value_valid = 'auto|' . $value_valid;
        }
        else
        {
            $value_valid = 'Modeline "' . '[0-9]+x[0-9]+'                       . '[^"]*" .*';
            $value_valid = 'auto|none|' . $value_valid;
        }
        return $value_valid;
    },
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = 'none';
        my $refresh    = $minimyth->var_get('MM_X_REFRESH');
        my $resolution = $minimyth->var_get('MM_X_RESOLUTION');
        if (($refresh) && ($resolution))
        {
            if ($refresh =~ /^(VertRefresh )?([0-9]+)-([0-9]+)(,.*)?/)
            {
                $refresh = ($2 + $3) / 2;
            }
            if ($resolution =~ /^([0-9]+)x([0-9]+)$/)
            {
                my $resolution_x = $1;
                my $resolution_y = $2;
                if ((-x '/usr/bin/gtf') &&
                    (open(FILE, '-|', "/usr/bin/gtf $resolution_x $resolution_y $refresh")))
                {
                    foreach (grep(/^ *Modeline /, (<FILE>)))
                    {
                        chomp;
                        s/ +/ /g;
                        s/^ //;
                        s/ $//;
                        $value_auto = $_;
                        last;
                    }
                }
            }
        }
        return $value_auto;
    },
    value_none    => ''
};
$var_list{'MM_X_MODELINE_0'} =
{
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/  +/ /g;
        $value_clean =~ s/^ //;
        $value_clean =~ s/ $//;
        $value_clean =~ s/^[Mm][Oo][Dd][Ee][Ll][Ii][Nn][Ee] "([0-9]+)[Xx]([0-9]+)([^"]*)" (.*)$/Modeline "$1x$2$3" $4/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'none',
    value_valid   => 'none|Modeline "[0-9]+[Xx][0-9]+[^"]*" .*',
    value_none    => ''
};
$var_list{'MM_X_MODELINE_1'} =
{
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/  +/ /g;
        $value_clean =~ s/^ //;
        $value_clean =~ s/ $//;
        $value_clean =~ s/^[Mm][Oo][Dd][Ee][Ll][Ii][Nn][Ee] "([0-9]+)[Xx]([0-9]+)([^"]*)" (.*)$/Modeline "$1x$2$3" $4/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'none',
    value_valid   => 'none|Modeline "[0-9]+[Xx][0-9]+[^"]*" .*',
    value_none    => ''
};
$var_list{'MM_X_MODELINE_2'} =
{
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/  +/ /g;
        $value_clean =~ s/^ //;
        $value_clean =~ s/ $//;
        $value_clean =~ s/^[Mm][Oo][Dd][Ee][Ll][Ii][Nn][Ee] "([0-9]+)[Xx]([0-9]+)([^"]*)" (.*)$/Modeline "$1x$2$3" $4/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'none',
    value_valid   => 'none|Modeline "[0-9]+[Xx][0-9]+[^"]*" .*',
    value_none    => ''
};
$var_list{'MM_X_MODE'} =
{
    prerequisite  => ['MM_VIDEO_ASPECT_RATIO', 'MM_VIDEO_RESIZE_ENABLED', 'MM_X_DRVER', 'MM_X_MODELINE', 'MM_X_OUTPUT_DVI', 'MM_X_OUTPUT_TV', 'MM_X_OUTPUT_VGA', 'MM_X_RESOLUTION', 'MM_X_TV_TYPE'],
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/^([0-9]+)[Xx]([0-9]+)(.*)$/$1x$2$3/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'auto',
    value_valid   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_valid = 'auto|none|[0-9]+x[0-9]+.*';
        my $modeline = $minimyth->var_get('MM_X_MODELINE');
        if (($modeline) && ($modeline =~ /^Modeline "([0-9]+x[0-9]+[^"]*)" .*/))
        {
            $value_valid = "auto|$1";
        }
        return $value_valid
    },
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = '';
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_MODELINE') =~ /^Modeline "([0-9]+x[0-9]+[^"]*)" .*/)
            {
                $value_auto = $1;
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_VIDEO_RESIZE_ENABLED') eq 'yes')
            {
                given ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO'))
                {
                    when (/^4:3$/)   {}
                    when (/^16:9$/)
                    {
                        given ($minimyth->var_get('MM_X_TV_TYPE'))
                        {
                            when (/^NTSC(-(J|M))?$/)                { $value_auto = '1280x720'; }
                            when (/^PAL(-(B|D|G|H|I|K1|M|N|NC))?$/) {}
                            when (/^(HD|hd)?480(I|i|P|p)$/)         { $value_auto = '720x480';  }
                            when (/^(HD|hd)?720(P|p)$/)             { $value_auto = '1280x720'; }
                            when (/^(HD|hd)?1080(I|i|P|p)$/)        { $value_auto = '1280x720'; }
                            when (/^(HD|hd)?576(I|i|P|p)$/)         {}
                        }
                    }
                    when (/^16:10$/) {}
                }
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_OUTPUT_DVI') ne 'none')
            {
                given ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO'))
                {
                    when (/^4:3$/)   { $value_auto = '800x600';  }
                    when (/^16:9$/)  { $value_auto = '1280x720'; }
                    when (/^16:10$/) { $value_auto = '1440x900'; }
                }
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_OUTPUT_VGA') ne 'none')
            {
                given ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO'))
                {
                    when (/^4:3$/)   { $value_auto = '800x600';  }
                    when (/^16:9$/)  { $value_auto = '1280x720'; }
                    when (/^16:10$/) { $value_auto = '1440x900'; }
                }
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_OUTPUT_TV') ne 'none')
            {
                given ($minimyth->var_get('MM_X_TV_TYPE'))
                {
                    when (/^NTSC(-(J|M))?$/)
                    {
                        given($minimyth->var_get('MM_X_DRIVER'))
                        {
                            when (/^openchrome$/){ $value_auto = '720x480Noscale'; }
                            default              { $value_auto = '720x480';        }
                        }
                    }
                    when (/^PAL(-(B|D|G|H|I|K1|M|N|NC))?$/)
                    {
                        given($minimyth->var_get('MM_X_DRIVER'))
                        {
                            when (/^openchrome$/){ $value_auto = '720x576Noscale'; }
                            default              { $value_auto = '720x576';        }
                        }
                    }
                    when (/^(HD|hd)?480(I|i)$/) {
                        $value_auto = '720x480';
                    }
                    when (/^(HD|hd)?480(P|p)$/)
                    {
                        given($minimyth->var_get('MM_X_DRIVER'))
                        {
                            when (/^openchrome$/){ $value_auto = '720x480Fit'; }
                            default              { $value_auto = '720x480';    }
                        }
                    }
                    when (/^(HD|hd)?720(P|p)$/)
                    {
                        $value_auto = '1280x720';
                    }
                    when (/^(HD|hd)?1080(I|i|P|p)$/)
                    {
                        $value_auto = '1920x1080';
                    }
                    when (/^(HD|hd)?576(I|i|P|p)$/)
                    {
                        $value_auto = '852x576';
                    }
                }
            }
        }
        if (! $value_auto)
        {
            $value_auto = 'none';
        }
        return $value_auto;
    },
    value_none    => ''
};
$var_list{'MM_X_MODE_0'} =
{
    prerequisite  => ['MM_VIDEO_ASPECT_RATIO', 'MM_VIDEO_RESIZE_ENABLED', 'MM_X_MODELINE_0', 'MM_X_TV_TYPE'],
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/^([0-9]+)[Xx]([0-9]+)(.*)$/$1x$2$3/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'auto',
    value_valid   => 'auto|none|[0-9]+[Xx][0-9]+.*',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = '';
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_MODELINE_0') =~ /^Modeline "([0-9]+x[0-9]+[^"]*)" .*/)
            {
                $value_auto = $1;
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_VIDEO_RESIZE_ENABLED') eq 'yes')
            {
                given ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO'))
                {
                    when (/^4:3$/)
                    {
                    }
                    when (/^16:9$/)
                    {
                        given ($minimyth->var_get('MM_X_TV_TYPE'))
                        {
                            when (/^NTSC(-(J|M))?$/)                { $value_auto = '1920x1080'; }
                            when (/^PAL(-(B|D|G|H|I|K1|M|N|NC))?$/) {}
                            when (/^(HD|hd)?480(I|i|P|p)$/)         { $value_auto = '720x480';   }
                            when (/^(HD|hd)?720(P|p)$/)             { $value_auto = '1920x720';  }
                            when (/^(HD|hd)?1080(I|i|P|p)$/)        { $value_auto = '1920x1080'; }
                            when (/^(HD|hd)?576(I|i|P|p)$/)         {}
                        }
                    }
                    when (/^16:10$/)
                    {
                    }
                }
            }
        }
        return $value_auto;
    }
};
$var_list{'MM_X_MODE_1'} =
{
    prerequisite  => ['MM_VIDEO_ASPECT_RATIO', 'MM_VIDEO_RESIZE_ENABLED', 'MM_X_MODELINE_1', 'MM_X_TV_TYPE'],
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/^([0-9]+)[Xx]([0-9]+)(.*)$/$1x$2$3/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'auto',
    value_valid   => 'auto|none|[0-9]+[Xx][0-9]+.*',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = '';
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_MODELINE_1') =~ /^Modeline "([0-9]+x[0-9]+[^"]*)" .*/)
            {
                $value_auto = $1;
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_VIDEO_RESIZE_ENABLED') eq 'yes')
            {
                given ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO'))
                {
                    when (/^4:3$/)
                    {
                    }
                    when (/^16:9$/)
                    {
                        given ($minimyth->var_get('MM_X_TV_TYPE'))
                        {
                            when (/^NTSC(-(J|M))?$/)                { $value_auto = '1280x720'; }
                            when (/^PAL(-(B|D|G|H|I|K1|M|N|NC))?$/) {}
                            when (/^(HD|hd)?480(I|i|P|p)$/)         { $value_auto = 'none';     }
                            when (/^(HD|hd)?720(P|p)$/)             { $value_auto = '720x480';  }
                            when (/^(HD|hd)?1080(I|i|P|p)$/)        { $value_auto = '1280x720'; }
                            when (/^(HD|hd)?576(I|i|P|p)$/)         {}
                        }
                    }
                    when (/^16:10$/)
                    {
                    }
                }
            }
        }
        return $value_auto;
    }
};
$var_list{'MM_X_MODE_2'} =
{
    prerequisite  => ['MM_VIDEO_ASPECT_RATIO', 'MM_VIDEO_RESIZE_ENABLED', 'MM_X_MODELINE_2', 'MM_X_TV_TYPE'],
    value_clean   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_clean = $minimyth->var_get($name);
        $value_clean =~ s/^([0-9]+)[Xx]([0-9]+)(.*)$/$1x$2$3/;
        $minimyth->var_set($name, $value_clean);

        return 1;
    },
    value_default => 'auto',
    value_valid   => 'auto|none|[0-9]+[Xx][0-9]+.*',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = '';
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_X_MODELINE_2') =~ /^Modeline "([0-9]+x[0-9]+[^"]*)" .*/)
            {
                $value_auto = $1;
            }
        }
        if (! $value_auto)
        {
            if ($minimyth->var_get('MM_VIDEO_RESIZE_ENABLED') eq 'yes')
            {
                given ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO'))
                {
                    when (/^4:3$/)
                    {
                    }
                    when (/^16:9$/)
                    {
                        given ($minimyth->var_get('MM_X_TV_TYPE'))
                        {
                            when (/^NTSC(-(J|M))?$/)                { $value_auto = '720x480'; }
                            when (/^PAL(-(B|D|G|H|I|K1|M|N|NC))?$/) {}
                            when (/^(HD|hd)?480(I|i|P|p)$/)         { $value_auto = 'none';    }
                            when (/^(HD|hd)?720(P|p)$/)             { $value_auto = 'none';    }
                            when (/^(HD|hd)?1080(I|i|P|p)$/)        { $value_auto = '720x480'; }
                            when (/^(HD|hd)?576(I|i|P|p)$/)         {}
                        }
                    }
                    when (/^16:10$/)
                    {
                    }
                }
            }
        }
        return $value_auto;
    }
};
$var_list{'MM_X_TV_TYPE'} =
{
    prerequisite  => ['MM_X_DRIVER'],
    value_default => sub
    {
        my $minimyth = shift;

        given ($minimyth->var_get('MM_X_DRIVER'))
        {
            when (/^nvidia$/    ) { return 'NTSC-M'; }
            when (/^openchrome$/) { return 'NTSC'  ; }
            default               { return 'NTSC'  ; }
        }
    },
    value_valid   => sub
    {
        my $minimyth = shift;

        given ($minimyth->var_get('MM_X_DRIVER'))
        {
            when (/^nvidia$/    ) { return 'PAL-(B|D|G|H|I|K1|M|N|NC)|NTSC-(J|M)|HD(480[ip]|576[ip]|720[p]|1080[ip])'; }
            when (/^openchrome$/) { return 'PAL|NTSC|480P|576P|720P|1080I'                                           ; }
            default               { return 'PAL|NTSC'                                                                ; }
        }
    }
};
$var_list{'MM_X_TV_OUTPUT'} =
{
    prerequisite  => ['MM_X_DRIVER'],
    value_default => sub
    {
        my $minimyth = shift;

        given ($minimyth->var_get('MM_X_DRIVER'))
        {
            when (/^nvidia$/    ) { return 'AUTOSELECT'; }
            when (/^openchrome$/) { return 'Composite' ; }
            default               { return 'Composite' ; }
        }
    },
    value_valid   => sub
    {
        my $minimyth = shift;

        given ($minimyth->var_get('MM_X_DRIVER'))
        {
            when (/^nvidia$/    ) { return 'AUTOSELECT|COMPOSITE|SVIDEO|COMPONENT|SCART'; }
            when (/^openchrome$/) { return 'Composite|S-Video|SC|RGP|YCbCr'             ; }
            default               { return 'Composite'                                  ; }
        }
    }
};
$var_list{'MM_X_TV_OVERSCAN'} =
{
    prerequisite  => ['MM_X_DRIVER'],
    value_default => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        given ($minimyth->var_get('MM_X_DRIVER'))
        {
            when (/^nvidia$/) { return '0.0'; }
            default           { return '0.0'; }
        }
    },
    value_valid   => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        given ($minimyth->var_get('MM_X_DRIVER'))
        {
            when (/^nvidia$/) { return '0([.][0-9]*)?|1([.]0*)?'; }
            default           { return '0([.]0*)?'              ; }
        }
    }
};
$var_list{'MM_X_VIRTUAL'} =
{
    prerequisite  => ['MM_X_MODE', 'MM_X_MODE_0', 'MM_X_MODE_1', 'MM_X_MODE_2'],
    value_default => 'auto',
    value_valid   => 'auto|[0-9]+x[0-9]+',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @modes;
        push(@modes, $minimyth->var_get('MM_X_MODE'));
        push(@modes, $minimyth->var_get('MM_X_MODE_0'));
        push(@modes, $minimyth->var_get('MM_X_MODE_1'));
        push(@modes, $minimyth->var_get('MM_X_MODE_2'));
        my $virtual_x = '0';
        my $virtual_y = '0';
        foreach (@modes)
        {
            if (/^([0-9]+)x([0-9]+).*$/)
            {
                if ($virtual_x < $1) { $virtual_x = $1; }
                if ($virtual_y < $2) { $virtual_y = $2; }
            }
        }
        return $virtual_x . 'x' . $virtual_y;
    }
};
$var_list{'MM_X_DISPLAYSIZE'} =
{
    prerequisite  => ['MM_VIDEO_ASPECT_RATIO', 'MM_VIDEO_FONT_SCALE', 'MM_X_VIRTUAL'],
    value_default => 'auto',
    value_valid   => 'auto|[0-9]+x[0-9]+',
    value_auto    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $displaysize_x = 0;
        my $displaysize_y = 0;

        my $virtual_x;
        my $virtual_y;
        if ($minimyth->var_get('MM_X_VIRTUAL') =~ /^([0-9]+)x([0-9]+)$/)
        {
            $virtual_x = $1;
            $virtual_y = $2;
        }

        my $aspect_ratio_x;
        my $aspect_ratio_y;
        if ($minimyth->var_get('MM_VIDEO_ASPECT_RATIO') =~ /^([0-9]+):([0-9]+)$/)
        {
            $aspect_ratio_x = $1;
            $aspect_ratio_y = $2;
        }

        my $font_scale = $minimyth->var_get('MM_VIDEO_FONT_SCALE');

        $displaysize_y = int(((($virtual_y * 100) / $font_scale) / 4) / $aspect_ratio_y) * $aspect_ratio_y;
        $displaysize_x = int(($displaysize_y * $aspect_ratio_x) / $aspect_ratio_y);

        return $displaysize_x . 'x' . $displaysize_y;
    }
};

1;
