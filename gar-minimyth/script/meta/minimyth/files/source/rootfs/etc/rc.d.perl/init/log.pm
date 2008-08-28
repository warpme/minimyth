#!/usr/bin/perl
################################################################################
# log
################################################################################
package init::log;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting system logging ...");

    my $log_server = undef;
    if ((-e '/etc/log.conf') && (open(FILE, '<', '/etc/log.conf')))
    {
        foreach (grep(s/^server +([^ ]+) *$/$1/, (<FILE>)))
        {
            $log_server = $_;
            last;
        }
        close(FILE);
    }
      
    if (defined($log_server))
    {
        if (qx(/bin/pidof klogd))
        {
            system(qq(/usr/bin/killall klogd));
        }
        if (qx(/bin/pidof syslogd))
        {
            system(qq(/usr/bin/killall syslogd));
        }
        system(qq(/sbin/syslogd -R "$log_server"));
    }
    if (! qx(/bin/pidof syslogd))
    {
        system(qq(/sbin/syslogd));
    }
    if (! qx(/bin/pidof klogd))
    {
        system(qq(/sbin/klogd));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "stopping system logging ...");

    if (qx(/bin/pidof klogd))
    {
        system(qq(/usr/bin/killall klogd));
    }
    if (qx(/bin/pidof syslogd))
    {
        system(qq(/usr/bin/killall syslogd));
    }

    return 1;
}

1;
