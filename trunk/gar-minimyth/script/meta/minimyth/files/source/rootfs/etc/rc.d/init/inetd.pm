################################################################################
# inetd
################################################################################
package init::inetd;

use strict;
use warnings;

use File::Find ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting inetd ...");

    my $http_true = '';
    my $ftp_true  = '';
    # Allow web access to the file system on machines that have security disabled.
    if ($minimyth->var_get('MM_SECURITY_ENABLED') ne 'no')
    {
        $ftp_true  = '#';
    }

    $minimyth->file_replace_variable(
        '/etc/inetd.conf',
        { '@MM_INETD_HTTP_TRUE@' => $http_true,
          '@MM_INETD_FTP_TRUE@'  => $ftp_true });

    system('/usr/sbin/inetd');

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('xinetd', "stopping inetd ...");

    return 1;
}

1;
