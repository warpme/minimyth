################################################################################
# hotplug
################################################################################
package init::hotplug;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "enabling udev hotplug scripts ...");

    # Real time clock.

    if (opendir(DIR, '/lib/udev/rules.d'))
    {
        foreach (grep(s/^(06-minimyth-hotplug-.*\.rules)\.disabled$/$1/, (readdir(DIR))))
        {
            rename("/lib/udev/rules.d/$_.disabled", "/lib/udev/rules.d/$_");
        }
        closedir(DIR);
    }
    system(qq(/sbin/udevadm trigger));
    system(qq(/sbin/udevadm settle --timeout=60));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
