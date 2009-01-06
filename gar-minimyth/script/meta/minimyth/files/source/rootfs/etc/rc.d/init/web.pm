#!/usr/bin/perl
################################################################################
# web
################################################################################
package init::web;

use strict;
use warnings;

use File::Find ();
require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting web server ...");

    my $uid = getpwnam('root');
    my $gid = getgrnam('httpd');
    File::Find::finddepth(
        sub
        {
            # Silence spurious warning caused by $File::Find::name being used only once.
            no warnings 'File::Find';
            chown($uid, $gid, $File::Find::name);
        },
        '/srv/www');

    # Web page.
    system(qq(/usr/bin/webfsd -s -u httpd -g httpd -4 -p 80 -j -r /srv/www -x /cgi-bin -f index.html));

    # Allow web access to the file system on machines that have security disabled.
    # It is run as root in order to provide access to all files.
    if ($minimyth->var_get('MM_SECURITY_ENABLED') eq 'no')
    {
        system(qq(/usr/bin/webfsd -s -u root -g root -4 -p 8080 -r /));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('webfsd', "stopping web server ...");

    return 1;
}

1;
