#!/usr/bin/perl
################################################################################
# log
################################################################################
package init::log;

use strict;
use warnings;

use MiniMyth ();

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
            chomp;
            $log_server = $_;
            last;
        }
        close(FILE);
    }
      
    if (defined($log_server))
    {
        $minimyth->application_stop('klogd');
        $minimyth->application_stop('syslogd');
        system(qq(/sbin/syslogd -R "$log_server"));
    }
    if (! $minimyth->application_running('syslogd'))
    {
        system(qq(/sbin/syslogd));
    }
    if (! $minimyth->application_running('klogd'))
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

    $minimyth->application_stop('klogd');
    $minimyth->application_stop('syslogd');

    return 1;
}

1;
