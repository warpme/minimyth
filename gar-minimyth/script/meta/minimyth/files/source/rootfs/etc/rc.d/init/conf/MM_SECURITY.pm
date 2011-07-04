################################################################################
# MM_SECURITY configuration variable handlers.
################################################################################
package init::conf::MM_SECURITY;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_SECURITY_ENABLED'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes'
};
$var_list{'MM_SECURITY_USER_MINIMYTH_UID'} =
{
    value_default  => '1000',
    value_valid    => '[0-9]+'
};
$var_list{'MM_SECURITY_USER_MINIMYTH_GID'} =
{
    value_default  => '1000',
    value_valid    => '[0-9]+'
};
$var_list{'MM_SECURITY_FETCH_CA_BUNDLE_CRT'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {name_remote => '/ca-bundle.crt',
                       name_local  => '/etc/pki/tls/certs/ca-bundle.crt'},
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        # Append the build-in ca-bundle.crt to the just fetched user ca-bundle.crt.
        if (! open(I_FILE, '<', '/initrd/rootfs-ro/etc/pki/tls/certs/ca-bundle.crt'))
        {
            $minimyth->message_output('err', qq(failed to open file '/initrd/rootfs-ro/etc/pki/tls/certs/ca-bundle.crt' for reading));
            return 0;
        }
        if (! open(O_FILE, '>>', '/etc/pki/tls/certs/ca-bundle.crt'))
        {
            $minimyth->message_output('err', qq(failed to open file '/etc/pki/tls/certs/ca-bundle.crt' for appending));
            close(I_FILE);
            return 0;
        }
        print O_FILE "\n";
        print O_FILE "# \n";
        print O_FILE "# Begin built-in bundle of digital certificates for trusted certificate authorities.\n";
        print O_FILE "# \n";
        print O_FILE "\n";
        while(<I_FILE>)
        {
            print O_FILE $_;
        }
        close(O_FILE);
        close(I_FILE);

        return 1;
    }

};
$var_list{'MM_SECURITY_FETCH_CREDENTIALS_CIFS'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {name_remote => '/credentials_cifs',
                       name_local  => '/etc/cifs/credentials_cifs',
                       mode_local  => '0600'}
};

1;
