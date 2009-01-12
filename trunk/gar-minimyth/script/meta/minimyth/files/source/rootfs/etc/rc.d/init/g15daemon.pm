################################################################################
# g15daemon
################################################################################
package init::g15daemon;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $devnull = File::Spec->devnull;

    if ($minimyth->var_get('MM_LCDPROC_DRIVER') eq 'g15')
    {
        $minimyth->message_output('info', "starting G15daemon ...");
        my $kernel_module = 'uinput';
        if (system(qq(/sbin/modprobe $kernel_module > $devnull 2>&1)) != 0)
        {
            $minimyth->message_output('err', "failed to load kernel module: $kernel_module");
            return 0;
        }
        # The g15daemon daemon does not create it configuration file, so init
        # creates it when it does not exist.
        if (! -e '/etc/g15daemon.conf')
        {
            if (open(FILE, '>', '/etc/g15daemon.conf'))
            {
                chmod(0644, '/etc/g15daemon.conf');
                close(FILE);
            }
            if (! -e '/etc/g15daemon.conf')
            {
                $minimyth->message_output('err', "failed to create file '/etc/g15daemon.conf'.");
                return 0;
            }
        }
        system(qq(/usr/sbin/g15daemon));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->application_running('g15daemon'))
    {
        $minimyth->message_output('info', "stopping G15daemon ...");
        system(qq(/usr/sbin/g15daemon -k));
    }

    return 1;
}

1;
