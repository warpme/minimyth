#!/usr/bin/perl
################################################################################
# minimyth.pm
#
# The optional MiniMyth configuration package.
#
# For information on this file, see either
# <http://minimyth.org/document.shtml>
# or
# <http://{frontend}/document.shtml>,
# where '{frontend}' is the IPv4 address or hostname of your MiniMyth frontend.
#
# A the time package is called, very little configuration has beeen completed.
# While kernel modules loaded by udev have been loaded, kernel modules loaded by
# other methods are not. In addition, very few services have been started.
# Finally, name resolution (i.e. DNS) has not been configured. As a result, you
# need to be careful about what you assume is available. In particular, you
# must use IP addresses rather than DNS names when refering to servers.
################################################################################

package init::minimyth;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

#    #---------------------------------------------------------------------------
#    # Function:
#    #   swap_init
#    #
#    # Description:
#    #   Initialize a network (often NFS) swap partition. This can be useful for
#    #   MiniMyth frontends that have too little memory to run without swap (i.e.
#    #   MiniMyth frontends that have less than 512MB of memory).
#    #
#    # Parameters:
#    #   minimyth:
#    #     Required.
#    #     The pointer to an instance of a MiniMyth object.
#    #   swap_url:
#    #     Required.
#    #     The URL that points to the remote directory that contains (or will
#    #     contain) the swap file. The MiniMyth frontend must have write access
#    #     as user 'root' to this remote directory.
#    #   swap_file:
#    #     Optional.
#    #     The name of the swap file in (or to be created in) the remote
#    #     directory pointed ot by URL $swap_url. If this file is not present
#    #     then MiniMyth will create it.  If this value is not present, then
#    #     it will be assumed to be '{hostname}.swap', where '{hostname}' is
#    #     the hostnme of the MiniMyth frontend.
#    #   swap_size:
#    #     Optional.
#    #     The size of the swap file in kilobytes. This value is used only when
#    #     creating the swap file. Therefore, if the swap file already exists
#    #     then this value is ignored. If this value is not present, then it will
#    #     be assumed to be 1024*1024.
#    #---------------------------------------------------------------------------
#    sub swap_init
#    {
#        my $minimyth  = shift;
#        my $swap_url  = shift;
#        my $swap_file = shift;
#        my $swap_size = shift;
#
#        ($minimyth ) || die qq(swap_init is missing required argument 'minimyth');
#        ($swap_url ) || die qq(swap_init is missing required argument 'swap_url');
#        ($swap_file) || ($swap_file = $minimyth->hostname() . '.swap');
#        ($swap_size) || ($swap_size = 1024 * 1024);
#
#        my $swap_device = '';
#        open(FILE, '-|', '/sbin/losetup -f') ||
#            die qq(swap_init failed to run command '/sbin/losetup -f');
#        while(<FILE>)
#        {
#            chomp;
#            $swap_device = $_;
#            last;
#        }
#        close(FILE);
#        ($swap_device) ||
#            die qq(swap_init failed to locate an available loopback device);
#        $minimyth->url_mount($swap_url, '/mnt/swap') || 
#            die qq(swap_init failed to mount '$swap_url' at '/mnt/swap');
#        (-w '/mnt/swap') ||
#            die qq(swap_init cannot write '$swap_url');
#        if (! -e "/mnt/swap/$swap_file")
#        {
#            system(qq(/bin/dd if='/dev/zero' of='/mnt/swap/$swap_file' bs=1024 count=$swap_size > /dev/null 2>&1)) &&
#                die qq(swap_init failed to create swap file '/mnt/swap/$swap_file');
#        }
#        system(qq(/sbin/losetup '$swap_device' '/mnt/swap/$swap_file' > /dev/null 2>&1)) &&
#            die qq(swap_init could not set up swap loopback device '$swap_device');
#        system(qq(/sbin/mkswap '$swap_device' > /dev/null 2>&1)) &&
#            die qq(swap_init could not make swap device '$swap_device');
#        system(qq(/sbin/swapon '$swap_device' > /dev/null 2>&1)) &&
#            die qq(swap_init could not enable swap device '$swap_device');
#    }
#    &swap_init($minimyth, 'nfs://myth.home/home/public/minimyth/swap');

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
