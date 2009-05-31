################################################################################
# web
################################################################################
package init::web;

use strict;
use warnings;

use File::Find ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting web server ...");

    # Web page.
    system(qq(/usr/sbin/lighttpd -f /etc/lighttpd-web.conf));

    # Allow web access to the file system on machines that have security disabled.
    # It is run as root in order to provide access to all files.
    if ($minimyth->var_get('MM_SECURITY_ENABLED') eq 'no')
    {
        system(qq(/usr/sbin/lighttpd -f /etc/lighttpd-dir.conf));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('lighttpd', "stopping web server ...");

    return 1;
}

1;
