#!/usr/bin/perl
################################################################################
# cron
################################################################################
package init::cron;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting cron ...");

    # If crond is not running and there is at least one file in the crontabs
    # directory, then start crond.
    if (! qx(/bin/pidof crond))
    {
        if ((-d '/var/spool/cron/crontabs') &&
            (opendir(DIR, '/var/spool/chron/crontabs')))
        {
            foreach (grep(! /^\./, (readdir(DIR))))
            {
                system(qq(/usr/sbin/crond));
                last;
            }
            closedir(DIR);
        }
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if (qx(/bin/pidof crond))
    {
        $minimyth->message_output('info', "stopping cron ...");
        system(qq(/usr/bin/killall crond));
    }

    return 1;
}

1;
