################################################################################
# dbus
################################################################################
package init::dbus;

use strict;
use warnings;

use File::Path ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;


    if (-e q(/usr/bin/dbus-uuidgen))
    {
        $minimyth->message_output('info', "initializing dbus ...");

        if (! -e q(/var/lib/dbus))
        {
            File::Path::mkpath(q(/var/lib/dbus), { mode => 0755 });
        }
        chmod(00755, q(/var/lib/dbus));
        system(qq(/usr/bin/dbus-uuidgen > /var/lib/dbus/machine-id));
        chmod(00644, q(/var/lib/dbus/machine-id));
    }

    if (-e q(/usr/libexec/dbus-daemon-launch-helper))
    {
        my $uid = getpwnam('root');
        my $gid = getgrnam('messagebus');
        if (((stat(q(/usr/libexec/dbus-daemon-launch-helper)))[4] != $uid) || ((stat(_))[5] != $gid))
        {
            chown($uid, $gid, q(/usr/libexec/dbus-daemon-launch-helper));
        }
        chmod(04750, q(/usr/libexec/dbus-daemon-launch-helper));
    }

    if ((-e q(/usr/bin/dbus-daemon)) && (-e q(/etc/dbus-1/system.conf)))
    {
        $minimyth->message_output('info', "starting dbus daemon ...");

        if (! -e q(/var/run/dbus))
        {
            File::Path::mkpath(q(/var/run/dbus), { mode => 0755 });
        }
        chmod(00755, q(/var/run/dbus));
        system(qq(/usr/bin/dbus-daemon --config-file=/etc/dbus-1/system.conf));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('dbus-daemon', "stopping dbus daemon ...");

    return 1;
}

1;
