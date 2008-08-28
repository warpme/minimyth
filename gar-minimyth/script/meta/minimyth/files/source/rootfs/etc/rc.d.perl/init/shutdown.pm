#!/usr/bin/perl
################################################################################
# shutdown
################################################################################
package init::shutdown;

use strict;
use warnings;

require MiniMyth;

sub _mountpoints_get
{
    my @mountpoints = ();
    if (open(FILE, '<', '/proc/mounts'))
    {
        while (<FILE>)
        {
            chomp;
            if (/^([^ ]*) ([^ ]*) ([^ ]*)/)
            {
                my $mountpoint = $2;
                if ( ($2 =~ /^\/$/)       ||
                     ($2 =~ /^\/initrd$/) )
                {
                    next;
                }
                if ( ($2 =~ /^\/media\//)      ||
                     ($2 =~ /^\/\/minimyth\//) ||
                     ($3 =~ /^cifs$/)          ||
                     ($3 =~ /^nfs$/)           )
                {
                    unshift(@mountpoints, $mountpoint);
                }
            }
        }
    }
    return \@mountpoints;
}

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "finishing shutdown ...");

    # unmount any remaining file systems.
    my @mountpoints = @{$self->_mountpoints_get()};
    for ( my $retry = 3 ; ($#mountpoints >= 0) && ($retry > 0) ; $retry-- )
    {
        foreach my $_ (@mountpoints)
        {
            $minimyth->message_output('info', "unmounting $_");
            system(qq(/bin/umount -f $_));
        }
        @mountpoints = @{$self->_mountpoints_get()};
        if (($#mountpoints >= 0) && ($retry > 0))
        {
            sleep 1;
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return $self->start($minimyth);
}

1;
