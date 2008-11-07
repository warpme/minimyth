#!/usr/bin/perl
################################################################################
# backend
################################################################################
package init::backend;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_BACKEND_ENABLED') eq 'yes')
    {
        $minimyth->message_output('info', "starting MythTV backend ...");

        if (-x '/usr/bin/mythbackend')
        {
            system(qq(/bin/su -c "/usr/bin/mythbackend --daemon" - minimyth));
        }
        else
        {
            $minimyth->message_output('err', "error: '/usr/bin/mythbackend' not found.");
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('mythbackend', "stopping MythTV backend ...");

    return 1;
}

1;
