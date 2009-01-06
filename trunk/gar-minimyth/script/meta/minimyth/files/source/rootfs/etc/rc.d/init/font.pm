#!/usr/bin/perl
################################################################################
# font
################################################################################
package init::font;

use strict;
use warnings;

use File::Path ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if (($minimyth->var_get('MM_FONT_FILE_TTF_DELETE')) || ($minimyth->var_get('MM_FONT_FILE_TTF_ADD')))
    {
        $minimyth->message_output('info', "updating fonts ...");

        File::Path::mkpath('/usr/lib/X11/fonts/TTF', { mode => 0755 });
        File::Path::mkpath('/usr/share/mythtv', { mode => 0755 });

        if ($minimyth->var_get('MM_FONT_FILE_TTF_DELETE'))
        {
            for (split(/  +/, $minimyth->var_get('MM_FONT_FILE_TTF_DELETE')))
            {
                unlink("/usr/lib/X11/fonts/TTF/$_");
                unlink("/usr/share/mythtv/$_");
            }
        }
        if ($minimyth->var_get('MM_FONT_FILE_TTF_ADD'))
        {
            for (split(/  +/, $minimyth->var_get('MM_FONT_FILE_TTF_ADD')))
            {
                unlink("/usr/share/mythtv/$_");
                if (-e "/usr/lib/X11/fonts/TTF/$_")
                {
                    symlink("/usr/lib/X11/fonts/TTF/$_", "/usr/share/mythtv/$_");
                }
            }
        }
        system(qq(cd /usr/lib/X11/fonts/TTF ; /usr/bin/mkfontscale ; /usr/bin/mkfontdir));
    }
    
    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
