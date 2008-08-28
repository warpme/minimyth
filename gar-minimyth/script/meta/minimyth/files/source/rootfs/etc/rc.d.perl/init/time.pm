#!/usr/bin/perl
################################################################################
# time
################################################################################
package init::time;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # Set time.
    $minimyth->message_output('info', "setting time ...");
    my @ntp_servers = ();
    if ((-e '/etc/ntp.conf') && (open(FILE, '<', '/etc/ntp.conf')))
    {
        foreach (grep(s/^server +([^ ]*) *$/$1/, (<FILE>)))
        {
            push(@ntp_servers, $_);
        }
        close(FILE);
    }
    my $ntp_success = 0;
    foreach (@ntp_servers)
    {
        if (system(qq(/usr/bin/ntpdate -b -s "$_")) == 0)
        {
            $ntp_success = 1;
            last;
        }
    }
    if ($ntp_success == 0)
    {
        $minimyth->message_output('warn', "warning: 'ntpd' failed to synchronize with any NTP server.");
    }

    # Start NTP daemon.
    $minimyth->message_output('info', "starting NTP daemon ...");
    system(qq(/usr/bin/ntpd -p /var/run/ntpd.pid));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "saving time ...");

    if (qx(/bin/pidof ntpd))
    {
        system(qq(/usr/bin/killall ntpd));
        system(qq(/sbin/hwclock -w -u));
    }

    return 1;
}

1;
