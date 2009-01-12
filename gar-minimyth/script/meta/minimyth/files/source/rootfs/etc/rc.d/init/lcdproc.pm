################################################################################
# lcdproc
################################################################################
package init::lcdproc;

use strict;
use warnings;

use File::Copy ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "starting LCD/VFD ...");

    # Only start the LCDd daemon when one is not running already.
    if (! $minimyth->application_running('LCDd'))
    {
        my $device                = $minimyth->var_get('MM_LCDPROC_DEVICE');
        my $driver                = $minimyth->var_get('MM_LCDPROC_DRIVER');
        my $kernel_module         = $minimyth->var_get('MM_LCDPROC_KERNEL_MODULE');
        my $kernel_module_options = $minimyth->var_get('MM_LCDPROC_KERNEL_MODULE_OPTIONS');

        # Load user configured kernel module.
        if ($kernel_module)
        {
            system(qq(/sbin/modprobe $kernel_module $kernel_module_options));
            # Wait up to 60 seconds for the device to appear in the device file system.
            for (my $delay = 0 ; ($delay < 60) && (! -e $device) ; $delay++)
            {
                $minimyth->message_output('info', "waiting for LCD/VFD device ($delay seconds) ...");
                sleep 1;
            }
            if (! -e $device)
            {
                $minimyth->message_output('err', "timed out waiting for LCD/VFD device.");
                return 0;
            }
        }

        # Load the LCDproc configuration file.
        if (! -e '/etc/LCDd.conf')
        {
            if ($driver)
            {
                if (-e "/etc/lcdproc.d/LCDd.conf.d/LCDd.conf.$driver")
                {
                    File::Copy::copy("/etc/lcdproc.d/LCDd.conf.d/LCDd.conf.$driver", '/etc/LCDd.conf');
                }
                else
                {
                    File::Copy::copy("/etc/lcdproc.d/LCDd.conf.d/LCDd.conf",         '/etc/LCDd.conf');
                }
            }
        }

        if (-e '/etc/LCDd.conf')
        {
            # Set the driver and device.
            $minimyth->file_replace_variable(
                '/etc/LCDd.conf',
                { '@MM_LCDPROC_DRIVER@' => $driver,
                  '@MM_LCDPROC_DEVICE@' => $device });
            # Start LCDproc LCDd daemon and Myth LCD server.
            system(qq(/usr/sbin/LCDd -c /etc/LCDd.conf));
        }
    }

    # Enable LCD in MythTV.
    if ($minimyth->application_running('LCDd'))
    {
        $minimyth->mythdb_settings_set('LCDEnable', '1');
    }
    else
    {
        $minimyth->mythdb_settings_set('LCDEnable', '0');
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('LCDd', "stopping LCD/VFD display ...");

    return 1;
}

1;
