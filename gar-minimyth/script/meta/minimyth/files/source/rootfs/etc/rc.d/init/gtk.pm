################################################################################
# gtk
################################################################################
package init::gtk;

use strict;
use warnings;

use File::Path ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "generating GTK related configuration files ...");

    if (-e q(/usr/bin/dbus-uuidgen))
    {
        if (! -e q(/var/lib/dbus))
        {
            File::Path::mkpath(q(/var/lib/dbus), { mode => 0755 });
        }
        chmod(0755, q(/var/lib/dbus));
        system(qq(/usr/bin/dbus-uuidgen > /var/lib/dbus/machine-id));
        chmod(0644, q(/var/lib/dbus/machine-id));
    }

    if (-e q(/usr/bin/gdk-pixbuf-query-loaders))
    {
        if (! -e q(/etc/gtk-2.0))
        {
            File::Path::mkpath(q(/etc/gtk-2.0), { mode => 0755 });
        }
        chmod(0755, q(/etc/gtk-2.0));
        system(qq(/usr/bin/gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders));
        chmod(0644, q(/etc/gtk-2.0/gdk-pixbuf.loaders));
    }

    if (-e q(/usr/bin/pango-querymodules))
    {
        if (! -e q(/etc/pango))
        {
            File::Path::mkpath(q(/etc/pango), { mode => 0755 });
        }
        chmod(0755, q(/etc/pango));
        system(qq(/usr/bin/pango-querymodules > /etc/pango/pango.modules));
        chmod(0644, q(/etc/pango/pango.modules));
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
