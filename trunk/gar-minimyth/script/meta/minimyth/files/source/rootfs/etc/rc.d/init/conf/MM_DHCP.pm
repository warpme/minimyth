################################################################################
# MM_DHCP configuration variable handlers.
################################################################################
package init::conf::MM_DHCP;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_DHCP_HOST_NAME'} =
{
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;
        if (-e '/var/cache/minimyth/init/state/conf/done-dhcp')
        {
            my $hostname = $minimyth->hostname();
            if (! $hostname)
            {
                $minimyth->message_output('err', qq('Host Name' (or 'MM_DHCP_HOST_NAME') not configured.));
                $success = 0;
            }
        }
        return $success;
    }
};
$var_list{'MM_DHCP_DOMAIN_NAME'} =
{
};
$var_list{'MM_DHCP_TCODE'} =
{
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;
        if (-e '/var/cache/minimyth/init/state/conf/done-dhcp')
        {
            if (! -e '/etc/localtime')
            {
                $minimyth->message_output('err', qq('TCode' (or 'MM_DHCP_TCODE') not configured.));
                $success = 0;
            }
        }
        return $success;
    }
};
$var_list{'MM_DHCP_DOMAIN_NAME_SERVERS'} =
{
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;
        if (-e '/var/cache/minimyth/init/state/conf/done-dhcp')
        {
            my $valid = 0;
            if (open(FILE, '<', '/etc/resolv.conf'))
            {
                while (<FILE>)
                {
                    chomp;
                    /^nameserver / && do { $valid = 1; };
                }
                close(FILE);
            }
            if ($valid == 0)
            {
                $minimyth->message_output('err', qq('Domain Name Servers' (or 'MM_DHCP_DOMAIN_NAME_SERVERS') not configured.));
                $success = 0;
            }
        }
        return $success;
    }
};
$var_list{'MM_DHCP_NTP_SERVERS'} =
{
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $success = 1;
        if (-e '/var/cache/minimyth/init/state/conf/done-dhcp')
        {
            my $valid = 0;
            if (open(FILE, '<', '/etc/ntp.conf'))
            {
                while (<FILE>)
                {
                    chomp;
                    /^server / && do { $valid = 1; };
                }
                close(FILE);
            }
            if ($valid == 0)
            {
                $minimyth->message_output('err', qq('NTP Servers' (or 'MM_DHCP_NTP_SERVERS') not configured.));
                $success = 0;
            }
        }
        return $success;
    }
};
$var_list{'MM_DHCP_LOG_SERVERS'} =
{
};

1;
