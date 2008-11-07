#!/usr/bin/perl
################################################################################
# irtrans
################################################################################
package init::irtrans;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if (($minimyth->var_get('MM_LCDPROC_DRIVER') eq 'irtrans') ||
        ($minimyth->var_get('MM_LIRC_DRIVER')    eq 'irtrans'))
    {
        if ($minimyth->var_get('MM_LCDPROC_DEVICE'))
        {
            $minimyth->message_output('info', "starting IRTrans server ...");
            # Use IRTrans server's LIRC support if
            # either the LIRC driver is 'irtrans',
            # or there is no other LIRC device.
            if (($minimyth->var_get('MM_LIRC_DRIVER') eq 'irtrans') ||
                (! $minimyth->var_get('MM_LIRC_DEVICE_LIST')))
            {
                system('/usr/sbin/irserver',
                       '-logfile', '/var/log/irserver',
		       '-pidfile', '/var/run/irserver.pid',
		       '-daemon',
                       $minimyth->var_get('MM_LCDPROC_DEVICE'));
            }
            else
            {
                system('/usr/sbin/irserver',
                       '-no_lirc',
                       '-logfile', '/var/log/irserver',
		       '-pidfile', '/var/run/irserver.pid',
		       '-daemon',
                       $minimyth->var_get('MM_LCDPROC_DEVICE'));
            }
        }
    }
    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->application_running('irserver'))
    {
        $minimyth->message_output('info', "stopping IRTrans server ...");
        if (-e '/usr/sbin/irclient')
        {
            system(qq(/usr/sbin/irclient localhost -shutdown));
        }
        else
        {
            system(qq(/usr/bin/killall irserver));
        }
    }
    return 1;
}

1;
