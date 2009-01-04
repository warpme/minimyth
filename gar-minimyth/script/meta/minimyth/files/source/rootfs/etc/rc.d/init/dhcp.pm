#!/usr/bin/perl
################################################################################
# dhcp
################################################################################
package init::dhcp;

use strict;
use warnings;

require MiniMyth;

# If there is no DHCP override variables file (/etc/conf.d/dhcp.override) then
# this routine will cause the DHCP client to run once and quit. Whereas, if
# there is a DHCP override variables file, then this routine will cause the DHCP
# client to run continuously.
sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # Start 'udhcpc'.
    if (! $minimyth->application_running('udhcpc'))
    {
        $minimyth->message_output('info', "starting DHCP client ...");

        # Create a 'udhcpc.conf' file.
        $minimyth->var_save({ file => '/etc/udhcpc.conf', filter => 'MM_DHCP_.*' });

        my $command = q(/sbin/udhcpc);
        $command = $command . ' ' .  q(-S);
        $command = $command . ' ' .  q(-p /var/run/udhcpc.pid);
        $command = $command . ' ' .  q(-s /etc/udhcpc.script);

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
        $command = $command . ' ' . qq(-i $interface);

        # Reuse any existing IP address.
        my $ip_address = '';
        if ((-x '/sbin/ifconfig') &&
            (open(FILE, '-|', "/sbin/ifconfig $interface")))
        {
            foreach (grep(s/^ *inet addr:([^ ]*) .*$/$1/, (<FILE>)))
            {
                $ip_address = $_;
                last;
            }
            close(FILE);
        }
        if ($ip_address)
        {
            $command = $command . ' ' . qq(-r $ip_address);
        }

        # Decide whether or not to run once.
        if (! -e '/etc/conf.d/dhcp.override')
        {
            $command = $command . ' ' . qq(-q);
        }

        $command = $command . ' ' .  q(> /var/log/udhcpc 2>&1);

        # Start DHCP client on the interface.
        if (system($command) != 0)
        {
            $minimyth->message_output('err', "DHCP on interface '$interface' failed.");
            return 0;
        }

        # Make sure we got an IP address.
        $ip_address = '';
        if ((-x '/sbin/ifconfig') &&
            (open(FILE, '-|', "/sbin/ifconfig $interface")))
        {
            foreach (grep(s/^ *inet addr:([^ ]*) .*$/$1/, (<FILE>)))
            {
                $ip_address = $_;
                last;
            }
            close(FILE);
        }
        if (! $ip_address)
        {
            $self->message_output('err', "DHCP on interface '$interface' failed.");
            return 0;
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('udhcpc', "stopping DHCP client ...");

    return 1;
}

1;
