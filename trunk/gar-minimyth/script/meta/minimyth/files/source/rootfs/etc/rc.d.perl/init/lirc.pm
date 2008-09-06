#!/usr/bin/perl
################################################################################
# lirc
#
# This script configures and starts LIRC.
################################################################################
package init::lirc;

use strict;
use warnings;

require File::Copy;
require MiniMyth;

sub _remote_wakeup_enable
{
    my $self        = shift;
    my $device_list = shift;

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
        if (open(FILE, '-|', "/sbin/udevadm info --query=name --path=/sys/class/lirc/$lirc"))
        {
            while (<FILE>)
            {
                chomp;
                $name = "/dev/$_";
                last;
            }
            close(FILE);
        }
        if (! grep(/^$name,.*$/, @{$device_list}))
        {
            next;
        }

        if ((! -r "/sys/class/lirc/$lirc/device/busnum") || 
            (! open(FILE, '<', "/sys/class/lirc/$lirc/device/busnum")))
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
    
        if ((! -r "/sys/class/lirc/$lirc/device/subsystem/devices/usb$busnum/serial") ||
            (! open(FILE, '<', "/sys/class/lirc/$lirc/device/subsystem/devices/usb$busnum/serial")))
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

    my @device_list = split(/  +/, $minimyth->var_get('MM_LIRC_DEVICE_LIST'));

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
            $minimyth->message_output('err', "error: timed out waiting for remote control device.");
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
        $daemon_master = $daemon_master . '--output=/dev/lircd --pidfile=/var/run/lircd.pid';
        for (my $index = 0 ; $index <= $#device_list ; $index++)
        {
            my $port = 8765 + $index;
            $daemon_master = $daemon_master . " --connect=localhost:$port"
        }
    }

    # If there is no lircd.conf file, then create it.
    if (! -e '/etc/lircd.conf')
    {
        my @lircd_conf_list = ();
        if (opendir(DIR, '/etc/lirc.d/lircd.conf.d'))
        {
            foreach (grep((/^lircd\.conf\./) && (-f "/etc/lirc.d/lircd.conf.d/$_"), (readdir(DIR))))
            {
                push(@lircd_conf_list, "/etc/lirc.d/lircd.conf.d/$_");
            }
            closedir(DIR);
        }
        if (open(FILE, '>', '/etc/lircd.conf'))
        {
            print FILE "# autogenerated\n";
            foreach (@lircd_conf_list)
            {
                print FILE "include <$_>\n";
            }
            close(FILE);
        }
    }

    # If there is no lircrc file, then create it.
    if (! -e '/etc/lircrc')
    {
        my @lircrc_list = ();
        push(@lircrc_list, '/etc/lirc.d/lircrc');
        if ($minimyth->var_get('MM_LIRC_SLEEP_ENABLED') eq 'yes')
        {
            push(@lircrc_list, '/etc/lirc.d/lircrc.power.sleep');
        }
        if ($minimyth->var_get('MM_EXTERNAL_VOLUME_ENABLED') eq 'yes')
        {
            push(@lircrc_list, '/etc/lirc.d/lircrc.volume.external');
        }
        else
        {
            push(@lircrc_list, '/etc/lirc.d/lircrc.volume.internal');
        }
        if (opendir(DIR, '/etc/lirc.d/lircrc.d'))
        {
            foreach (grep((/^lircrc\./) && (-f "/etc/lirc.d/lircrc.d/$_"), (readdir(DIR))))
            {
                push(@lircrc_list, "/etc/lirc.d/lircrc.d/$_");
            }
            closedir(DIR);
        }
        if (open(FILE, '>', '/etc/lircrc'))
        {
            print FILE "# autogenerated\n";
            foreach (@lircrc_list)
            {
                print FILE "include $_\n";
            }
            close(FILE);
        }
   }

    # Create directories used by the LIRC daemon.
    mkdir('/var/lock', 0755);
    mkdir('/var/run', 0755);

    # Start an LIRC daemon for each device.
    my $index = 0;
    foreach my $device_item (@device_list)
    {
        my @device_args = split(/,/, $device_item);
        my $device = $device_args[0];
        my $driver = $device_args[1];

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

        # Start daemon.
        my $daemon = '';
        my $instance = $device;
        $instance =~ s/\/\/+/~/g;
        $instance =~ s/^~dev~//;
        if ($daemon_master)
        {
            my $port = 8765 + $index;
            $daemon = '/usr/sbin/lircd';
            $daemon = $daemon . " --device=$device --driver=$driver";
            $daemon = $daemon . " --output=/dev/lircd-$instance --pidfile=/var/run/lircd-$instance.pid";
            $daemon = $daemon . " --listen=$port";
        }
        else
        {
            $daemon = '/usr/sbin/lircd';
            $daemon = $daemon . " --device=$device --driver=$driver";
            $daemon = $daemon . ' --output=/dev/lircd --pidfile=/var/run/lircd.pid';
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

    # Enable wakeup on remote.
    if ($minimyth->var_get('MM_LIRC_WAKEUP_ENABLED') eq 'yes')
    {
        $self->_remote_wakeup_enable(\@device_list);
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
