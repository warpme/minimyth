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

    if (-e q(/usr/bin/gdk-pixbuf-query-loaders))
    {
        if (! -e q(/usr/lib/gdk-pixbuf-2.0/2.10.0/))
        {
            File::Path::mkpath(q(/usr/lib/gdk-pixbuf-2.0/2.10.0/), { mode => 0755 });
        }
        chmod(0755, q(/usr/lib/gdk-pixbuf-2.0/2.10.0/));
	system(qq(/usr/bin/gdk-pixbuf-query-loaders --update-cache));
        chmod(0644, q(/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache));
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
