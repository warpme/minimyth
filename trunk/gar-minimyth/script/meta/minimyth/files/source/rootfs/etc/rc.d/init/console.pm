################################################################################
# console
################################################################################
package init::console;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # Run a virtual console on machines that have security disabled.
    if ($minimyth->var_get('MM_SECURITY_ENABLED') eq 'no')
    {
        if (! $minimyth->application_running('agetty'))
        {
            $minimyth->message_output('info', "starting virtual console ...");
            system(qq(/sbin/agetty 9600 tty1 &));
        }
    }
    # Otherwise, stop the virtual console.
    else
    {
        $self->stop($minimyth);
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('agetty', "stopping virtual console ...");

    return 1;
}

1;
