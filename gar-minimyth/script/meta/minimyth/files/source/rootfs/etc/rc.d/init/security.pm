################################################################################
# security
################################################################################
package init::security;

use strict;
use warnings;

use File::Find ();
use Lchown qw(lchown);
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

    # Make sure that uid and gid for the home directory of user 'minimyth' are correct.
    {
        my $uid = getpwnam('minimyth');
        my $gid = getgrnam('minimyth');
        File::Find::finddepth(
            sub
            {
                if (((lstat($File::Find::name))[4] != $uid) || ((lstat(_))[5] != $gid))
                {
                    lchown($uid, $gid, $File::Find::name);
                }
            },
            '/home/minimyth');
    }

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
