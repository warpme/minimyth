################################################################################
# dhcp_oneshot
################################################################################
package init::dhcp_oneshot;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # Start 'udhcpc'.
    if (! $minimyth->application_running('udhcpc'))
    {
        $minimyth->message_output('info', "configuring network interface (one shot) ...");

        # Create a 'udhcpc.conf' file.
        $minimyth->var_save({ file => '/etc/udhcpc.conf', filter => 'MM_DHCP_.*' });

        # Determine network interface.
        my $interface = $minimyth->var_get('MM_NETWORK_INTERFACE');
        if (! $interface)
        {
            # No network interface was found.
            $minimyth->message_output('err', "no network interface found.");
            return 0;
        }

        # If the client's address has not been manually configured, then run the DHCP client.
        if (! $minimyth->var_get('MM_DHCP_ADDRESS'))
        {
            my $command = q(/sbin/udhcpc);
            $command = $command . ' ' .  q(-S);

            $command = $command . ' ' . q(-o);
            $command = $command . ' ' . q(-O subnet);
            $command = $command . ' ' . q(-O router);
            $command = $command . ' ' . q(-O dns);
            $command = $command . ' ' . q(-O logsrv);
            $command = $command . ' ' . q(-O hostname);
            $command = $command . ' ' . q(-O domain);
            $command = $command . ' ' . q(-O broadcast);
            $command = $command . ' ' . q(-O ntpsrv);
            $command = $command . ' ' . q(-O tcode);

            $command = $command . ' ' .  q(-p /var/run/udhcpc.pid);
            $command = $command . ' ' .  q(-s /etc/udhcpc.script);

            $command = $command . ' ' . qq(-i $interface);

            # Reuse any existing IP address.
            my $ip_address = '';
            if ((-x '/sbin/ifconfig') &&
                (open(FILE, '-|', "/sbin/ifconfig $interface")))
            {
                foreach (grep(s/^ *inet addr:([^ ]*) .*$/$1/, (<FILE>)))
                {
                    chomp $_;
                    $ip_address = $_;
                    last;
                }
                close(FILE);
            }
            if ($ip_address)
            {
                $command = $command . ' ' . qq(-r $ip_address);
            }

            # Obtain a lease and then quit.
            $command = $command . ' ' . qq(-q);

            $command = $command . ' ' .  q(> /var/log/udhcpc 2>&1);

            # Start DHCP client on the interface.
            $minimyth->message_log('info', qq(running DHCP client command '$command'.));
            if (system($command) != 0)
            {
                $minimyth->message_output('err', "dynamic configuratoin of interface '$interface' failed.");
                return 0;
            }
        }
        else
        {
            my $command = qq(/bin/sh -c 'interface=$interface /etc/udhcpc.script renew');
            if (system($command) != 0)
            {
                $minimyth->message_output('err', "static configuration of interface '$interface' failed.");
                return 0;
            }
        }

        # Make sure we got an IP address.
        my $ip_address = '';
        if ((-x '/sbin/ifconfig') &&
            (open(FILE, '-|', "/sbin/ifconfig $interface")))
        {
            foreach (grep(s/^ *inet addr:([^ ]*) .*$/$1/, (<FILE>)))
            {
                chomp $_;
                $ip_address = $_;
                last;
            }
            close(FILE);
        }
        if (! $ip_address)
        {
            $minimyth->message_output('err', "configuration of network interface '$interface' failed.");
            return 0;
        }
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
