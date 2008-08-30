#!/usr/bin/perl
################################################################################
# ssh_server
#
# This script configures the ssh server.
################################################################################
package init::ssh_server;

use strict;
use warnings;

require File::Copy;
require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "configuring ssh server ...");

    my $uid = getpwnam('root');
    my $gid = getgrnam('root');

    if (-e '/etc/ssh/sshd_config')
    {
        chmod(0600,       '/etc/ssh/sshd_config');
        chown($uid, $gid, '/etc/ssh/sshd_config');
    }

    if (-e '/etc/ssh/ssh_host_rsa_key')
    {
        chmod(0600,       '/etc/ssh/ssh_host_rsa_key');
        chown($uid, $gid, '/etc/ssh/ssh_host_rsa_key');
    }

    if (-e '/etc/ssh/authorized_keys')
    {
        chmod(0600,       '/etc/ssh/authorized_keys');
        chown($uid, $gid, '/etc/ssh/authorized_keys');

        mkdir('/root/.ssh', 0755);
        File::Copy::copy('/etc/ssh/authorized_keys', '/root/.ssh/authorized_keys');
        chmod(0600,       '/root/.ssh/authorized_keys');
        chown($uid, $gid, '/root/.ssh/authorized_keys');
    }

    if ($minimyth->var_get('MM_SSH_SERVER_ENABLED') eq 'yes')
    {
        if (qx(/bin/pidof sshd))
        {
            $minimyth->message_output('info', "starting ssh server ...");
            mkdir('/var/empty', 0755);
            system(qq(/usr/sbin/sshd));
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if (qx(/bin/pidof sshd))
    {
        $minimyth->message_output('info', "stopping ssh server ...");
        system(qq(/usr/bin/killall sshd));
    }

    return 1;
}

1;
