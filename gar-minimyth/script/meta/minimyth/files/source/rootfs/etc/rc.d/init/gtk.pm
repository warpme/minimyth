################################################################################
# gtk
################################################################################
package init::gtk;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "configuring GTK ...");

    if (-e q(/usr/bin/gdk-pixbuf-query-loaders))
    {
        if (! -e q(/etc/gtk-2.0))
        {
            mkdir(q(/etc/gtk-2.0));
        }
        chmod(0755, q(/etc/gtk-2.0));
        system(qq(/usr/bin/gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders));
        chmod(0644, q(/etc/gtk-2.0/gdk-pixbuf.loaders));
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
