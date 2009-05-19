################################################################################
# lirc
################################################################################
package init::lirc;

use strict;
use warnings;

use Cwd ();
use File::Basename ();
use File::Path ();
use MiniMyth ();

sub _remote_wakeup_enable
{
    my $self   = shift;
    my $device = shift;

    if ((! -r '/sys/class/lirc') ||
        (! opendir(DIR, '/sys/class/lirc')))
    {
        return 1;
    }
    my @lirc_list = ();
    foreach (grep(! /^\./, (readdir(DIR))))
    {
        push(@lirc_list, $_);
    }
    closedir(DIR);
    
    foreach my $lirc (@lirc_list)
    {
        my $name = '';
        if (open(FILE, '-|', qq(/sbin/udevadm info --query=name --root --path='/sys/class/lirc/$lirc')))
        {
            while (<FILE>)
            {
                chomp;
                $name = $_;
                last;
            }
            close(FILE);
        }
        if ($name ne $device)
        {
            next;
        }

        my $devpath = Cwd::abs_path(qq(/sys/class/lirc/$lirc/device));
        $devpath = File::Basename::dirname($devpath);
        $devpath = File::Basename::dirname($devpath);

        if ((! -r "$devpath/busnum") || 
            (! open(FILE, '<', "$devpath/busnum")))
        {
            next;
        }
        my $busnum = undef;
        foreach (grep(/^[0-9]+$/,(<FILE>)))
        {
            chomp;
            $busnum = $_;
            last;
        }
        close(FILE);
        if (! defined($busnum))
        {
            next;
        }
    
        if ((! -r "$devpath/subsystem/devices/usb$busnum/serial") ||
            (! open(FILE, '<', "$devpath/subsystem/devices/usb$busnum/serial")))
        {
            next;
        }
        my $serial = undef;
        foreach (grep(! /^$/,(<FILE>)))
        {
            chomp;
            $serial = $_;
            last;
        }
        close(FILE);
        if (! defined($serial))
        {
            next;
        }

        if ((! -r '/proc/acpi/wakeup') ||
            (! open(FILE, '<', '/proc/acpi/wakeup')))
        {
            next;
        }
        my $entry = undef;
        foreach (grep(/$serial$/, (<FILE>)))
        {
            chomp;
            $entry = $_;
        }
        close(FILE);
        if (! defined($entry))
        {
            next;
        }

        my $device = (split(/ +/, $entry))[0];
        if ((! defined($device)) || ($device eq ''))
        {
            next;
        }

        my $status = (split(/ +/, $entry))[2];
        if ((! defined($status)) || ($status eq ''))
        {
            next;
        }
        
        if ($status ne 'enabled')
        {
            if ((! -w '/proc/acpi/wakeup') ||
                (! open(FILE, '>', '/proc/acpi/wakeup')))
            {
                next;
            }
            print FILE $device . "\n";
            close(FILE);
        }
    }

    return 1;
}

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my @device_list = split(/ +/, $minimyth->var_get('MM_LIRC_DEVICE_LIST'));

    # There are no remote control devices, so there is no need to continue.
    if (($#device_list + 1) <= 0)
    {
        return 1;
    }

    $minimyth->message_output('info', "starting remote control(s) ...");

    my $device                = $minimyth->var_get('MM_LIRC_DEVICE');
    my $driver                = $minimyth->var_get('MM_LIRC_DRIVER');
    my $kernel_module         = $minimyth->var_get('MM_LIRC_KERNEL_MODULE');
    my $kernel_module_options = $minimyth->var_get('MM_LIRC_KERNEL_MODULE_OPTIONS');

    # Load user configured kernel module.
    if ($kernel_module)
    {
        system(qq(/sbin/modprobe $kernel_module $kernel_module_options));
        # Wait up to 60 seconds for the device to appear in the device file system.
        # Wait up to 60 seconds for the device to appear in the device file system.
        for (my $delay = 0 ; ($delay < 60) && (! -e $device) ; $delay++)
        {
            $minimyth->message_output('info', "waiting for remote control device ($delay seconds) ...");
            sleep 1;
        }
        if (! -e $device)
        {
            $minimyth->message_output('err', "timed out waiting for remote control device.");
            return 0;
        }
    }

    # Determine master LIRC daemon.
    # The master LIRC daemon combines the LIRC daemons for multiple LIRC devices.
    # Therefore, if there is more than one LIRC device, then we need a master LIRC daemon.
    my $daemon_master = '';
    if (($#device_list + 1) > 1)
    {
        $daemon_master = '/usr/sbin/lircd';
        $daemon_master = $daemon_master . ' --driver=null';
        $daemon_master = $daemon_master . ' --output=/dev/lircd --pidfile=/var/run/lircd.pid';
        for (my $index = 0 ; $index <= $#device_list ; $index++)
        {
            my $port = 8765 + $index;
            $daemon_master = $daemon_master . " --connect=localhost:$port"
        }
    }

    # If there is no lircd.conf file, then create it.
    if (! -e '/etc/lircd.conf')
    {
        my $lircd_conf_path = q(/etc/lirc.d/lircd.conf);
        my @lircd_conf_list = ();
        if (opendir(DIR, $lircd_conf_path))
        {
            foreach (grep((! /^\./) && (-f qq($lircd_conf_path/$_)), (readdir(DIR))))
            {
                push(@lircd_conf_list, qq($lircd_conf_path/$_));
            }
            closedir(DIR);
        }
        if (open(FILE, '>', q(/etc/lircd.conf)))
        {
            print FILE qq(# autogenerated\n);
            foreach (sort @lircd_conf_list)
            {
                print FILE qq(include <$_>\n);
            }
            close(FILE);
        }
    }

    # If there is no lircrc file, then create it.
    if (! -e '/etc/lircrc')
    {
        my $lircrc_path = q(/etc/lirc.d/lircrc);
        # Create a list of lircrc applications.
        my @application_path_list = ();
        if (opendir(DIR, $lircrc_path))
        {
            foreach (grep((! /^\./), (readdir(DIR))))
            {
                push(@application_path_list, qq($lircrc_path/$_));
            }
            closedir(DIR);
        }

        # Create a list of lircrc files.
        my @lircrc_list = ();
        foreach my $application_path (@application_path_list)
        {
            # Add all lircrc application files to the lircrc file list.
            if    (-f $application_path)
            {
                push(@lircrc_list, $application_path);
            }
            # Process all lircrc application directories.
            elsif (-d $application_path)
            {
                # Add all files in the lircrc application directory to the lircrc file list.
                if (opendir(DIR, $application_path))
                {
                    foreach (grep(((! /^\./) && (-f qq($application_path/$_)), (readdir(DIR)))))
                    {
                        push(@lircrc_list, qq($application_path/$_));
                    }
                    closedir(DIR);
                }
                # Add files for the power key(s).
                if ($minimyth->var_get('MM_LIRC_SLEEP_ENABLED') eq 'yes')
                {
                    if (-f qq($application_path/optional/key.power.sleep))
                    {
                        push(@lircrc_list, qq($application_path/optional/key.power.sleep));
                    }
                }
                # Add files for the volume key(s).
                if ($minimyth->var_get('MM_EXTERNAL_VOLUME_ENABLED') eq 'yes')
                {
                    if (-f qq($application_path/optional/key.volume.external))
                    {
                        push(@lircrc_list, qq($application_path/optional/key.volume.external));
                    }
                }
                else
                {
                    if (-f qq($application_path/optional/key.volume.internal))
                    {
                        push(@lircrc_list, qq($application_path/optional/key.volume.internal));
                    }
                }
            }
        }
        if (open(FILE, '>', q(/etc/lircrc)))
        {
            print FILE qq(# autogenerated\n);
            foreach (sort @lircrc_list)
            {
                print FILE qq(include $_\n);
            }
            close(FILE);
        }
   }

    # Create directories used by the LIRC daemon.
    File::Path::mkpath('/var/lock', { mode => 0755 });
    File::Path::mkpath('/var/run', { mode => 0755 });

    # Enable wakeup and start an LIRC daemon for each device.
    my $index = 0;
    foreach my $device_item (@device_list)
    {
        my @device_args = split(/,/, $device_item);
        my $device     = $device_args[0];
        my $driver     = $device_args[1];
        my $lircd_conf = $device_args[2];

        # Convert driver to the the lirc daemon appropriate driver.
        if (($driver) && (open(FILE, '-|', '/usr/sbin/lircd --driver=help 2>&1')))
        {
            my $driver_actual = 'default';
            while (<FILE>)
            {
	        chomp;
                s/[[:cntrl:]]//g;
                if (/^$driver$/)
                {
                    $driver_actual = $_;
                }
            }
            $driver = $driver_actual;
        }

        # Enable wakeup on remote.
        if ($minimyth->var_get('MM_LIRC_WAKEUP_ENABLED') eq 'yes')
        {
            $self->_remote_wakeup_enable($device);
        }

        # Start daemon.
        my $daemon = '';
        my $instance = $device;
        $instance =~ s/\/+/~/g;
        $instance =~ s/^~dev~//;
        if ($daemon_master)
        {
            my $port = 8765 + $index;
            $daemon = '/usr/sbin/lircd';
            $daemon = $daemon . " --device=$device --driver=$driver";
            $daemon = $daemon . " --output=/dev/lircd-$instance --pidfile=/var/run/lircd-$instance.pid";
            $daemon = $daemon . " --listen=$port";
            $daemon = $daemon . " $lircd_conf";
        }
        else
        {
            $daemon = '/usr/sbin/lircd';
            $daemon = $daemon . " --device=$device --driver=$driver";
            $daemon = $daemon . ' --output=/dev/lircd --pidfile=/var/run/lircd.pid';
            $daemon = $daemon . " $lircd_conf";
            symlink('/dev/lircd', "/dev/lircd-$instance");
        }
        $minimyth->message_log('info', "started '$daemon'.");
        system(qq($daemon));

        $index++;
    }

    # Start master LIRC daemon.
    if ($daemon_master)
    {
        system(qq($daemon_master));
    }

    my $irexec_enabled = $minimyth->var_get('MM_LIRC_IREXEC_ENABLED');

    # Auto-configure usage of 'irexec'.
    if ($irexec_enabled eq 'auto')
    {
        $minimyth->message_log('info', "attempting to auto-configure usage of 'irexec'.");
        $irexec_enabled = 'no';
        if (-e '/etc/lircrc')
        {
            # Only one level of includes is supported.
            my @lircrc_list = ();
            push(@lircrc_list, '/etc/lircrc');
            if (open(FILE, '<', '/etc/lircrc'))
            {
                foreach (grep(s/^include +(.*)$/$1/, (<FILE>)))
                {
                    chomp;
                    push(@lircrc_list, $_);
                }
                close(FILE);
            }
            foreach my $lircrc_file (@lircrc_list)
            {
                if (open(FILE, '<', $lircrc_file))
                {
                    foreach (grep(/^ *prog *= *irexec *$/, (<FILE>)))
                    {
                        $irexec_enabled = 'yes';
                        if ($irexec_enabled eq 'yes')
                        {
                            last;
                        }
                    }
                    close(FILE);
                }
                if ($irexec_enabled eq 'yes')
                {
                    last;
                }
            }
        }
        $minimyth->message_log('info', "auto-configured usage of 'irexec' as '$irexec_enabled'.");
    }

    # Start the irexec daemon.
    if ($irexec_enabled eq 'yes')
    {
        system(qq(/usr/bin/irexec -d /etc/lircrc));
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if (($minimyth->application_running('irexec')) || ($minimyth->application_running('lircd')))
    {
        $minimyth->message_output('info', "stopping remote control ...");

        $minimyth->application_stop('irexec');
        $minimyth->application_stop('lircd');
    }

    return 1;
}

1;
