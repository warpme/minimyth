################################################################################
# conf
################################################################################
package init::conf;

use strict;
use warnings;

use Cwd ();
use File::Basename ();
use File::Path ();
use MiniMyth ();

# Steps:
#   (1)  Check for MM_MINIMYTH_BOOT_URL.
#   (2)  If MiniMyth boot directory is local, then wait for it to mount.
#   (3)  Fetch minimyth.conf.
#   (4)  Reprocess MM_MINIMYTH_BOOT_URL,
#        since it can be overrridden by minimyth.conf.
#   (5)  Process MM_MINIMYTH_FETCH_MINIMYTH_PM.
#   (6)  If configured to do so, then fetch and run minimyth.pm.
#   (7)  Process DHCP override variables.
#   (8)  Start DHCP.
#   (9)  Enable udev based auto-detection,
#        including hardware firmware files.
#   (10) Process MM_FIRMWARE_FILE_LIST,
#        including fetching any hardware firmware files.
#   (11) Load automatic kernel modules.
#   (12) Process MM_HARDWARE_KERNEL_MODULE_LIST.
#   (13) Load manual kernel modules.
#   (14) (Re)process all configuration variables.
sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $dir = Cwd::abs_path(File::Basename::dirname(__FILE__));

    $minimyth->package_require(q(init::conf::base));
    $minimyth->package_member_require(q(init::conf::base), q(list_run));

    # This is a hack for testing that should never get invoked during normal boot.
    File::Path::rmtree('/var/cache/minimyth/init/state/conf') if (-e '/var/cache/minimyth/init/state/conf');
    unlink('/etc/conf.d/dhcp.override')                       if (-e '/etc/conf.d/dhcp.override');
    unlink('/etc/conf.d/minimyth')                            if (-e '/etc/conf.d/minimyth');

    my $success = 1;

    # Create conf state directory.
    File::Path::mkpath('/var/cache/minimyth/init/state/conf', { mode => 0755 });

    # Read configuration.
    $minimyth->var_clear();
    $minimyth->var_load({ 'file' => '/etc/conf' });

    # If the MiniMyth boot directory was not set to a local path on the boot
    # line, then we may need the network interface in order to access the
    # MiniMyth boot directory.
    if ( (! $minimyth->var_get('MM_MINIMYTH_BOOT_URL')            ) ||
         (  $minimyth->var_get('MM_MINIMYTH_BOOT_URL') !~ /^file:/) )
        {
        init::conf::base->list_run($minimyth, 'MM_NETWORK_INTERFACE');
        $minimyth->package_require(q(init::dhcp_oneshot));
        if ($minimyth->package_member_require(q(init::dhcp_oneshot), q(start)))
        {
            eval
            {
                init::dhcp_oneshot->start($minimyth) || ($success = 0);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                $success = 0;
            }
        }
        # Reread configuration to take into account configuration from DHCP.
        $minimyth->var_clear();
        $minimyth->var_load({ 'file' => '/etc/conf' });
    }

    $minimyth->message_output('info', "fetching configuration file  ...");

    # Determine current boot directory location.
    if (! init::conf::base->list_run($minimyth, 'MM_MINIMYTH_BOOT_URL'))
    {
        $minimyth->message_output('err', "cannot determine 'MM_MINIMYTH_BOOT_URL'.");
        return 0;
    }

    # Using local configuration files, so there should be a '/minimyth' directory.
    if ($minimyth->var_get('MM_MINIMYTH_BOOT_URL') eq 'file:/minimyth/')
    {
        for (my $countdown = 30; (! -e '/minimyth') && ($countdown > 0) ; $countdown--)
        {
            $minimyth->message_output('info', "waiting for directory /minimyth to mount ($countdown second(s) left) ...");
            sleep 1;
        }
        if (! -e '/minimyth')
        {
            $minimyth->message_output('err', "directory /minimyth failed to mount.");
            return 0;
        }
    }

    # Get MiniMyth configuration file.
    $minimyth->confro_get('/minimyth.conf', '/etc/minimyth.d/minimyth.conf');

    # Make sure that there is a MiniMyth configuration file.
    if (! -e '/etc/minimyth.d/minimyth.conf')
    {
        $minimyth->message_output('err', "'minimyth.conf' not found.");
        return 0;
    }
    if (! -r '/etc/minimyth.d/minimyth.conf')
    {
        $minimyth->message_output('err', "'minimyth.conf' not readable.");
        return 0;
    }

    # Save the current boot directory location so that it is available to the
    # 'mm_minimyth_conf_include shell' shell function that might be called from
    # within '/etc/minimyth.d/minimyth.conf' when it is read.
    $minimyth->var_save({ 'file' => '/etc/conf.d/minimyth.raw', 'filter' => 'MM_MINIMYTH_BOOT_URL' });

    # Read MiniMyth configuration file variables.
    $minimyth->var_clear();
    $minimyth->var_load({ 'file' => '/etc/minimyth.d/minimyth.conf' });

    unlink('/etc/conf.d/minimyth.raw');

    $minimyth->message_output('info', "checking for obsolete variables ...");
    if (open(FILE, '<', "$dir/conf/obsolete"))
    {
        while (<FILE>)
        {
            chomp;
            if ($minimyth->var_exists($_))
            {
                $minimyth->message_output('err', "'minimyth.conf' is out of date. '$_' is obsolete.");
                $success = 0;
            }
        }
        close(FILE);
    }

    # Fetch and run 'minimyth.pm'.
    init::conf::base->list_run($minimyth, 'MM_MINIMYTH_FETCH_MINIMYTH_PM') || ($success = 0);
    if ($minimyth->var_get('MM_MINIMYTH_FETCH_MINIMYTH_PM') eq 'yes')
    {
        $minimyth->message_output('info', "fetching configuration package ...");
        unlink('/etc/minimyth.d/minimyth.pm');
        $minimyth->confro_get('/minimyth.pm', '/etc/minimyth.d/minimyth.pm');
        if (! -e '/etc/minimyth.d/minimyth.pm')
        {
            $minimyth->message_output('err', "failed to fetch 'minimyth.pm' file.");
            $success = 0;
        }
    }
    if (-f '/etc/minimyth.d/minimyth.pm')
    {
        unlink("$dir/minimyth.pm");
        symlink('/etc/minimyth.d/minimyth.pm', "$dir/minimyth.pm");
    }
    if (-f "$dir/minimyth.pm")
    {
        $minimyth->package_require(q(init::minimyth));

        # Validate minimyth.pm.
        $minimyth->package_member_require(q(init::minimyth), q(start));
        $minimyth->package_member_require(q(init::minimyth), q(stop));

        if ($minimyth->package_member_exists(q(init::minimyth), q(start)))
        {
            $minimyth->message_output('info', "running configuration package ...");
            eval
            {
                init::minimyth->start($minimyth) || ($success = 0);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                $success = 0;
            }
        } 
    }

    # Process the DHCP override configuration variables
    # so that they are available to the DHCP client.
    $minimyth->message_output('info', "Processing DHCP override variables ...");
    init::conf::base->list_run($minimyth, 'MM_DHCP_.*') || ($success = 0);
    $minimyth->var_save({ 'file' => '/etc/conf.d/dhcp.override', 'filter' => 'MM_DHCP_.*' });

    if (open(FILE, '>', '/var/cache/minimyth/init/state/conf/done-dhcp_override_file'))
    {
        close(FILE);
    }
    else
    {
        $success = 0;
    }

    # Start the DHCP client now that we have created the DHCP override variables file.
    init::conf::base->list_run($minimyth, 'MM_NETWORK_INTERFACE');
    $minimyth->package_require(q(init::dhcp));
    if ($minimyth->package_member_require(q(init::dhcp), q(start)))
    {
        eval
        {
            init::dhcp->start($minimyth) || ($success = 0);
        };
        if ($@)
        {
            $minimyth->message_output('err', qq($@));
            $success = 0;
        }
    }

    if (open(FILE, '>', '/var/cache/minimyth/init/state/conf/done-dhcp'))
    {
        close(FILE);
    }
    else
    {
        $success = 0;
    }

    # Enable and trigger configuration auto-detection udev rules.
    # Some auto-detection rules may not trigger because the
    # automatic and manual kernel modules have yet to be loaded.
    # The firmware auto-detection rules will trigger because they do
    # do not depend on the automatic and manual kernel modules.
    if (opendir(DIR, '/lib/udev/rules.d'))
    {
        foreach (grep(s/^(05-minimyth-detect-.*\.rules)\.disabled$/$1/, (readdir(DIR))))
        {
            rename("/lib/udev/rules.d/$_.disabled", "/lib/udev/rules.d/$_");
        }
        closedir(DIR);
    }
    system(qq(/sbin/udevadm trigger));
    system(qq(/sbin/udevadm settle --timeout=60));

    # Fetch firmware files.
    $minimyth->message_output('info', "Fetching firmware files ...");
    init::conf::base->list_run($minimyth, 'MM_FIRMWARE_FILE_LIST') || ($success = 0);

    # Load the automatic kernel modules.
    $minimyth->package_require(q(init::modules_automatic));
    if ($minimyth->package_member_require(q(init::modules_automatic), q(start)))
    {
        eval
        {
            init::modules_automatic->start($minimyth) || ($success = 0);
        };
        if ($@)
        {
            $minimyth->message_output('err', qq($@));
            $success = 0;
        }
    }

    # Load the manual kernel modules.
    init::conf::base->list_run($minimyth, 'MM_HARDWARE_KERNEL_MODULE_LIST');
    $minimyth->package_require(q(init::modules_manual));
    if ($minimyth->package_member_require(q(init::modules_manual), q(start)))
    {
        eval
        {
            init::modules_manual->start($minimyth) || ($success = 0);
        };
        if ($@)
        {
            $minimyth->message_output('err', qq($@));
            $success = 0;
        }
    }

    # (Re)process all the configuration variables.
    $minimyth->message_output('info', "processing configuration file ...");
    $minimyth->var_clear();
    $minimyth->var_load({ 'file' => '/etc/minimyth.d/minimyth.conf' });
    init::conf::base->list_run($minimyth) || ($success = 0);
    $minimyth->var_save();

    return $success;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    my $dir = Cwd::abs_path(File::Basename::dirname(__FILE__));

    # Run 'minimyth.pm'.
    if (-f "$dir/minimyth.pm")
    {
        require init::minimyth;
        if (exists(&init::minimyth::stop))
        {
            $minimyth->message_output('info', "running configuration package ...");
            eval
            {
                init::minimyth->stop($minimyth);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
            }
        }
    }

    return 1;
}

1;
