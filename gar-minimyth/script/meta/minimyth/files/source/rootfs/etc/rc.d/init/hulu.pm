################################################################################
# version
################################################################################
package init::hulu;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_HULU_URL'))
    {
        $minimyth->message_output('info', "installing binary Hulu Desktop ...");
        $minimyth->url_get($minimyth->var_get('MM_HULU_URL'), '/usr/bin/huludesktop');
    }
    if (-f '/usr/bin/huludesktop')
    {
        chmod(0755, '/usr/bin/huludesktop');
        if (-e '/lib/ld-linux.so.2')
        {
            if (system(qq(/lib/ld-linux.so.2 --list /usr/bin/huludesktop > /dev/null 2>&1)) != 0)
            {
                $minimyth->message_output('err', 'Hulu Desktop will fail because libraries are missing.')
            }
        }
        if (-e '/lib/ld-linux-x86-64.so.2')
        {
            if (system(qq(/lib/ld-linux-x86-64.so.2 --list /usr/bin/huludesktop > /dev/null 2>&1)) != 0)
            {
                $minimyth->message_output('err', 'Hulu Desktop will fail because libraries are missing.')
            }
        }
        if (! -e '/usr/lib/browser/plugins/libflashplayer.so')
        {
            $minimyth->message_output('err', 'Hulu Desktop will fail because Adobe Flash Player is missing.')
        }
        my $gui_x        = $minimyth->mythdb_settings_get('GuiWidth');
        my $gui_y        = $minimyth->mythdb_settings_get('GuiHeight');
        my $gui_x_offset = $minimyth->mythdb_settings_get('GuiOffsetX');
        my $gui_y_offset = $minimyth->mythdb_settings_get('GuiOffsetY');
        if (! defined($gui_x))
        {
            $gui_x = 0;
        }
        if (! defined($gui_y))
        {
            $gui_y = 0;
        }
        if (! defined($gui_x_offset))
        {
            $gui_x_offset = 0;
        }
        if (! defined($gui_y_offset))
        {
            $gui_y_offset = 0;
        }

        my $remote = $minimyth->var_get('MM_HULU_REMOTE');

        $minimyth->file_replace_variable(
            '/home/minimyth/.huludesktop',
            { '@GUI_X@'        => $gui_x,
              '@GUI_Y@'        => $gui_y,
              '@GUI_X_OFFSET@' => $gui_x_offset,
              '@GUI_Y_OFFSET@' => $gui_y_offset,
              '@REMOTE@'       => $remote });
    }
    else
    {
        $minimyth->file_replace_variable(
            '/usr/share/mythtv/library.xml',
            { '<type>HULU</type>' => '<type>HULU</type><depends>disabled</depends>' });
        $minimyth->file_replace_variable(
            '/usr/share/mythtv/themes/classic/mainmenu.xml',
            { '<type>HULU</type>' => '<type>HULU</type><depends>disabled</depends>' });
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
