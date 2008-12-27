#!/usr/bin/perl
################################################################################
# wiimote
################################################################################
package init::wiimote;

use strict;
use warnings;

require File::Spec;
require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $address_0 = $minimyth->var_get('MM_WIIMOTE_ADDRESS_0');
    my $address_1 = $minimyth->var_get('MM_WIIMOTE_ADDRESS_1');
    my $address_2 = $minimyth->var_get('MM_WIIMOTE_ADDRESS_2');
    my $address_3 = $minimyth->var_get('MM_WIIMOTE_ADDRESS_3');

    if ((defined($address_0)) || (defined($address_1)) || (defined($address_2)) || (defined($address_3)))
    {
        $minimyth->message_output('info', "starting bluetooth ...");

        my $devnull = File::Spec->devnull;

        my @devices = ();
        if ((-e '/sys/class/bluetooth') && (opendir(DIR, '/sys/class/bluetooth')))
        {
            foreach (grep(! /\./, (readdir(DIR))))
            {
                push(@devices, $_);
            }
        }
        if ($#devices < 0)
        {
            $minimyth->message_output('err', "error: no bluetooth device found.");
            return 0;
        }

        my $device_configured = 0;
        foreach my $device (@devices)
        {
            if (system(qq(/usr/sbin/hciconfig $device up > $devnull 2>&1)) == 0)
            {
                $device_configured = 1;
            }
            else
            {
                $minimyth->message_output('warn', "warning: configuration of bluetooth device '$device' failed.");
            }
        }
        if ($device_configured == 0)
        {
            $minimyth->message_output('err', "error: no bluetooth device configured.");
            return 0;
        }

        $minimyth->message_output('info', "starting wminput ...");

        # wminput is already running, so return.
        if ($minimyth->application_running('wminput'))
        {
            return 1;
        }

        # Load uinput driver as needed.
        if (! -e q(/dev/uinput))
        {
            if (system(qq(/sbin/modprobe uinput > $devnull 2>&1)) != 0)
            {
                $minimyth->message_output('err', "error: failed to load kernel module: uinput");
                return 0;
            }
            while (! -e q(/dev/uinput))
            {
                sleep 1;
            }
        }

        if ($address_0)
        {
            my $config = undef;
            if    (-e '/etc/cwiid/wminput/default')
            {
                $config = '/etc/cwiid/wminput/default';
            }
            elsif (-e '/etc/cwiid/wminput/default_0')
            {
                $config = '/etc/cwiid/wminput/default_0';
            }
            if (! defined($config))
            {
                $minimyth->message_output('err', "error: no 'wminput' config file found.");
                return 0;
            }
            system(qq(/usr/bin/wminput -d -c $config $address_0 > $devnull 2>&1 &));
        }
        if ($address_1)
        {
            my $config = undef;
            if    (-e '/etc/cwiid/wminput/default')
            {
                $config = '/etc/cwiid/wminput/default';
            }
            elsif (-e '/etc/cwiid/wminput/default_1')
            {
                $config = '/etc/cwiid/wminput/default_1';
            }
            if (! defined($config))
            {
                $minimyth->message_output('err', "error: no 'wminput' config file found.");
                return 0;
            }
            system(qq(/usr/bin/wminput -d -c $config $address_1 > $devnull 2>&1 &));
        }
        if ($address_2)
        {
            my $config = undef;
            if    (-e '/etc/cwiid/wminput/default')
            {
                $config = '/etc/cwiid/wminput/default';
            }
            elsif (-e '/etc/cwiid/wminput/default_2')
            {
                $config = '/etc/cwiid/wminput/default_2';
            }
            if (! defined($config))
            {
                $minimyth->message_output('err', "error: no 'wminput' config file found.");
                return 0;
            }
            system(qq(/usr/bin/wminput -d -c $config $address_2 > $devnull 2>&1 &));
        }
        if ($address_3)
        {
            my $config = undef;
            if    (-e '/etc/cwiid/wminput/default')
            {
                $config = '/etc/cwiid/wminput/default';
            }
            elsif (-e '/etc/cwiid/wminput/default_3')
            {
                $config = '/etc/cwiid/wminput/default_3';
            }
            if (! defined($config))
            {
                $minimyth->message_output('err', "error: no 'wminput' config file found.");
                return 0;
            }
            system(qq(/usr/bin/wminput -d -c $config $address_3 > $devnull 2>&1 &));
        }
    }

    return 1;
}


sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('wminput', "stopping wminput ...");

    return 1;
}

1;
