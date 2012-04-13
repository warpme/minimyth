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

    if (opendir(DIR, '/usr/lib/udev/rules.d'))
    {
        foreach (grep(s/^(06-minimyth-hotplug-.*\.rules)\.disabled$/$1/, (readdir(DIR))))
        {
            rename("/usr/lib/udev/rules.d/$_.disabled", "/usr/lib/udev/rules.d/$_");
        }
        closedir(DIR);
    }
    system(qq(/usr/bin/udevadm control --reload));
    system(qq(/usr/bin/udevadm trigger --action=add));
    system(qq(/usr/bin/udevadm settle --timeout=60));

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
