#!/usr/bin/perl
################################################################################
# dhcp
################################################################################
package init::dhcp;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # Create a 'udhcpc.conf' file.
    $minimyth->var_save({ file => '/etc/udhcpc.conf', filter => 'MM_DHCP_.*' });

    # If 'udhcpc' is running, then stop it.
    $self->stop($minimyth);

    # Start 'udhcpc'.
    if (! qx(/bin/pidof udhcpc))
    {
        $minimyth->message_output('info', "starting DHCP client ...");

        # Determine network interface.
        my $interface = $minimyth->var_get('MM_NETWORK_INTERFACE');
        if (! $interface)
        {
            # Locate a connected network interface.
            # We use the first connected network interface found.
            if ((-d '/sys/class/net') &&
                (opendir(DIR, '/sys/class/net')))
            {
                foreach (grep((! /^\./) && (! /^lo$/), (readdir(DIR))))
                {
                    if ((system(qq(/usr/sbin/ifplugstatus -q $_)) >> 8) == 2)
                    {
                        $interface = $_;
                    }
                }
            }
            # No network interface was found.
            if (! $interface)
            {
                $minimyth->message_output('info', "no network interface found, defaulting to 'eth0'.");
                $interface = 'eth0';
            }
        }

        # Start DHCP on the interface.
        my $ip_address = '';
        if ((-x '/sbin/ifconfig') &&
            (open(FILE, '-|', "/sbin/ifconfig $interface")))
        {
            foreach (grep(/^ *inet addr:/, (<FILE>)))
            {
                chomp;
                if (/^ *inet addr:([^ ]*) .*/)
                {
                    $ip_address = $1;
                    last;
                }
            }
            close(FILE);
        }
        if (! $ip_address)
        {
            if (system(qq(/sbin/udhcpc -S -p /var/run/udhcpc.pid -s /etc/udhcpc.script -i $interface                > /var/log/udhcpc 2>&1)) != 0)
            {
                $minimyth->message_output('err', "error: DHCP on interface '$interface' failed.");
                return 0;
            }
        }
        else
        {
            if (system(qq(/sbin/udhcpc -S -p /var/run/udhcpc.pid -s /etc/udhcpc.script -i $interface -r $ip_address > /var/log/udhcpc 2>&1)) != 0)
            {
                $minimyth->message_output('err', "error: DHCP on interface '$interface' failed.");
                return 0;
            }
        }

        # Make sure we got an IP address.
        $ip_address = '';
        if ((-x '/sbin/ifconfig') &&
            (open(FILE, '-|', "/sbin/ifconfig $interface")))
        {
            foreach (grep(/^ *inet addr:/, (<FILE>)))
            {
                chomp;
                if (/^ *inet addr:([^ ]*) .*/)
                {
                    $ip_address = $1;
                    last;
                }
            }
            close(FILE);
        }
        if (! $ip_address)
        {
            $self->message_output('err', "error: DHCP on interface '$interface' failed.");
            return 0;
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if (qx(/bin/pidof udhcpc))
    {
        $minimyth->message_output('info', "stopping DHCP client ...");
        while (qx(/bin/pidof udhcpc))
        {
            system(qq(/usr/bin/killall udhcpc));
        }
    }

    return 1;
}

1;
