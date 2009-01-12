################################################################################
# cron
################################################################################
package init::cron;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting cron ...");

    # If crond is not running and there is at least one file in the crontabs
    # directory, then start crond.
    if (! $minimyth->application_running('crond'))
    {
        if ((-d '/var/spool/cron/crontabs') &&
            (opendir(DIR, '/var/spool/cron/crontabs')))
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

    $minimyth->application_stop('crond', "stopping cron ...");

    return 1;
}

1;
