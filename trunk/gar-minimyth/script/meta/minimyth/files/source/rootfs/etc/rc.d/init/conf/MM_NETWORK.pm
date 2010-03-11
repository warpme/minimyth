################################################################################
# MM_NETWORK configuration variable handlers.
################################################################################
package init::conf::MM_NETWORK;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_NETWORK_INTERFACE'} =
{
    value_default  => 'auto',
    value_valid    => 'auto|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = '';

        my @interface_list = ();
        if ((-d '/sys/class/net') &&
            (opendir(DIR, '/sys/class/net')))
        {
            foreach (grep((! /^\./) && (! /^lo$/), (readdir(DIR))))
            {
                push(@interface_list, $_);
            }
        }

        # Use the first connected interface with existing IP address.
        if (! $value_auto)
        {
            foreach my $interface (@interface_list)
            {
                if ((system(qq(/usr/sbin/ifplugstatus -q $interface)) >> 8) == 2)
                {
                    if ((-x '/sbin/ifconfig') &&
                        (open(FILE, '-|', "/sbin/ifconfig $interface")))
                    {
                        my $ip_address = '';
                        foreach (grep(s/^ *inet addr:([^ ]*) .*$/$1/, (<FILE>)))
                        {
                            $value_auto = $interface;
                            last;
                        }
                    }
                }
            }
        }

        # Use the first connected interface.
        if (! $value_auto)
        {
            foreach my $interface (@interface_list)
            {
                if ((system(qq(/usr/sbin/ifplugstatus -q $interface)) >> 8) == 2)
                {
                    $value_auto = $interface;
                    last;
                }
            }
        }

        # Use the first interface.
        if (! $value_auto)
        {
            foreach my $interface (@interface_list)
            {
                $value_auto = $interface;
                last;
            }
        }
                
        return $value_auto;
    },
};

1;
