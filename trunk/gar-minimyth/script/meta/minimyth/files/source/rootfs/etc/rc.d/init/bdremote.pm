################################################################################
# bdremote
################################################################################
package init::bdremote;

use strict;
use warnings;

use Cwd ();
use File::Basename ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_LIRC_DRIVER') eq 'bdremote')
    {
        $minimyth->message_output('info', "starting Sony PS3 Blu-ray Disc Remote Control daemon ...");

        my $daemon = '/usr/sbin/bdremoteng';
        $daemon = $daemon . " -l";
        $daemon = $daemon . " -E";
        $daemon = $daemon . " -a " . $minimyth->var_get('MM_LIRC_DEVICE');
        $daemon = $daemon . " -t 30";
        $daemon = $daemon . " -p 8765";
        system(qq($daemon));

        if ($minimyth->var_get('MM_LIRC_WAKEUP_ENABLED') eq 'yes')
        {
            my @devices = split(/ +/, $minimyth->var_get('MM_BLUETOOTH_DEVICE_LIST'));

            foreach my $device (@devices)
            {
                if (-e qq(/sys/class/bluetooth/$device/device))
                {
                    my $dir = Cwd::abs_path(qq(/sys/class/bluetooth/$device/device));
                    while ($dir !~ /^\/sys\/devices(\/)?$/) 
                    {
                        if (-e qq($dir/power/wakeup))
                        {
                            if (open(FILE, '<', qq($dir/power/wakeup)))
                            {
                                my $state = undef;
                                while(<FILE>)
                                {
                                    chomp;
                                    $state = $_;
                                }
                                close(FILE);
                                if ($state =~ /^disabled$/)
                                {
                                    if (open(FILE, '>', qq($dir/power/wakeup)))
                                    {
                                        print FILE "enabled\n";
                                        close(FILE);
                                    }
                                }
                            }
                        }
                        $dir = File::Basename::dirname($dir);
                    }
                }
            }
        }
    }
    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->application_stop('bdremoteng', "stopping Sony PS3 Blu-ray Disc Remote Control daemon ...");

    return 1;
}

1;
