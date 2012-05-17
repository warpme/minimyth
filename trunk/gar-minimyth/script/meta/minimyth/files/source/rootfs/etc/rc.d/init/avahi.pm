################################################################################
# avahi
################################################################################
package init::avahi;

use strict;
use warnings;

use File::Path ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if (-e q(/home/minimyth/.mythtv/RAOPKey.rsa))
    {
        if ((-e q(/usr/sbin/avahi-daemon)) && (-e q(/etc/avahi/avahi-daemon.conf)))
        {
            $minimyth->message_output('info', "starting avahi daemon ...");

            my $uid = getpwnam('avahi');
            my $gid = getgrnam('avahi');

            if (! -e q(/etc/avahi/services))
            {
                File::Path::mkpath(q(/etc/avahi/services), { mode => 0755 });
            }

            if (! -e q(/var/run/avahi-daemon))
            {
                File::Path::mkpath(q(/var/run/avahi-daemon), { mode => 0755 });
            }

            chmod(00755, q(/var/run/avahi-daemon));
            chown($uid, $gid, q(/var/run/avahi-daemon));

            system(qq(/usr/sbin/avahi-daemon --daemonize --file=/etc/avahi/avahi-daemon.conf));
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('avahi-daemon', "stopping avahi daemon ...");

    return 1;
}

1;
