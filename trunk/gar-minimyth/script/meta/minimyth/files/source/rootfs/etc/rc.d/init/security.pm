################################################################################
# security
################################################################################
package init::security;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $user_minimyth_uid = $minimyth->var_get('MM_SECURITY_USER_MINIMYTH_UID');
    my $user_minimyth_gid = $minimyth->var_get('MM_SECURITY_USER_MINIMYTH_GID');
    $minimyth->file_replace_variable(
        '/etc/passwd',
        { 'minimyth::1000:1000:' => "minimyth::$user_minimyth_uid:$user_minimyth_gid:" });
    $minimyth->file_replace_variable(
        '/etc/group',
        { 'minimyth:x:1000:' => "minimyth:x:$user_minimyth_gid:" });

    if (-e '/etc/ssl/certs/ca-bundle.crt')
    {
        # Set permissions.
        chmod(0644, '/etc/ssl/certs/ca-bundle.crt');
        # Link to the default name.
        unlink('/etc/ssl/cert.pem');
        symlink('/etc/ssl/certs/ca-bundle.crt', '/etc/ssl/cert.pem');
        # Add KSSL's bundle.
        if ((-w '/usr/kde/share/apps/kssl/ca-bundle.crt') && (open(OFILE, '>>', '/usr/kde/share/apps/kssl/ca-bundle.crt')))
        {
            if ((-r '/etc/ssl/certs/ca-bundle.crt') && (open(IFILE, '<', '/etc/ssl/certs/ca-bundle.crt')))
            {
                while (<IFILE>)
                {
                    print OFILE $_;
                }
                close(IFILE);
            }
            close(OFILE);
        }
    }

    if (-e '/etc/cifs/credentials_cifs')
    {
        # Set permissions.
        chmod(0600, '/etc/cifs/credentials_cifs');
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
