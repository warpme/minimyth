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

    if ($minimyth->var_get('MM_HULU_STORE_HULUDESKTOP_DATA') eq 'yes')
    {
        my $name_remote = '/huludesktop.data';
        my $name_local  = '/home/minimyth/.local/share/.huludesktop.data';
        my $result = $minimyth->confrw_get($name_remote, $name_local);
        if (! -e $name_local)
        {
            $minimyth->message_output('info', qq(failed to fetch MiniMyth read-write configuration file ') . $name_remote . qq('));
        }
        else
        {
            $minimyth->message_log('info', qq(fetched MiniMyth read-write configuration file ') . $name_remote . qq('));
            $minimyth->message_log('info', qq(  by fetching ') . $result . qq('));
            $minimyth->message_log('info', qq(  to local file ') . $name_local . qq('.));
            chmod(oct('0644'), $name_local);
        }
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

        my $remote = $minimyth->var_get('MM_HULU_REMOTE');

        $minimyth->file_replace_variable(
            '/home/minimyth/.huludesktop',
            { '@REMOTE@' => $remote });
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
