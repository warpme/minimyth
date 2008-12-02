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

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    # NFS mount a swap partition.
    # This can be useful for MiniMyth frontends that have too little memory to
    # run without swap (i.e. MiniMyth frontends that have less than 512MB of
    # memory).
    # For this to work, you need to prepare the swap file on the server. This is
    # done using the command:
    #   'cd {swap-dir} ; dd if=/dev/zero of=<swap-file> bs=1k count=<swap-size}'
    # where <swap-dir> is the directory that will be exported and mounted on
    # the frontend as the directory containing the swap file, <swap-file> is the
    # name of the swap file, and <swap-size> is the size of the swap file in
    # kilobytes. Remember to use different swap files for each MiniMyth frontend.
#    {
#        my $swap_url    = '<swap-url>';
#        my $swap_file   = '<swap-file>';
#        my $swap_device = '';
#        open(FILE, '-|', '/sbin/losetup -f') || die;
#        while(<FILE>)
#        {
#            chomp;
#            $swap_device = $_;
#            last;
#        }
#        close(FILE);
#        if ((! $swap_url) || (! $swap_file) || (! $swap_device))
#        {
#            die;
#        }
#        $minimyth->url_mount($swap_url, '/mnt/swap') || die;
#        system(qq(/sbin/losetup $swap_device "/mnt/swap/$swap_file")) && die;
#        system(qq(/sbin/mkswap $swap_device)) && die;
#        system(qq(/sbin/swapon $swap_device)) && die;
#    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
