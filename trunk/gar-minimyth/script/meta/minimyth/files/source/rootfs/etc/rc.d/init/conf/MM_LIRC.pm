################################################################################
# MM_LIRC configuration variable handlers.
################################################################################
package init::conf::MM_LIRC;

use strict;
use warnings;

my %var_list;

sub var_list
{
    return \%var_list;
}

$var_list{'MM_LIRC_AUTO_ENABLED'} =
{
    prerequisite   => ['MM_LIRC_DRIVER'],
    value_default  => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_default;
        if (! $minimyth->var_get('MM_LIRC_DRIVER'))
        {
            $value_default = 'yes';
        }
        else
        {
            $value_default = 'no';
        }
        return $value_default;
    },
    value_valid    => 'yes|no'
};
$var_list{'MM_LIRC_DEVICE_BLACKLIST'} =
{
    value_default  => ''
};
$var_list{'MM_LIRC_DRIVER'} =
{
    value_default  => 'none',
    value_valid    => 'none|.+',
    value_obsolete => 'auto|mceusbnew',
    value_none     => '',
};
$var_list{'MM_LIRC_DEVICE'} =
{
    prerequisite   => ['MM_LIRC_DRIVER'],
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $value_auto = '';
       
        my $driver = $minimyth->var_get('MM_LIRC_DRIVER');
        if ($driver)
        {
            my $driver_file = "/etc/lirc.d/driver.conf/$driver";
            if ((-r $driver_file) && (open(FILE, '<', $driver_file)))
            {
                while (<FILE>)
                {
                    chomp;
                    /^$name='([^']*)'$/ && do { $value_auto = $1; };
                }
                close(FILE);
            }
        }
        return $value_auto;
    },
    value_none     => '',
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $device = $minimyth->var_get($name);
        if (($device) && (! -e $device))
        {
            $minimyth->message_output('err', "Remote control device '$device' specified by '$name' does not exist.");
            return 0;
        }

        return 1;
    },
};
$var_list{'MM_LIRC_KERNEL_MODULE'} =
{
    prerequisite   => ['MM_LIRC_DRIVER'],
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $auto = '';
       
        my $driver = $minimyth->var_get('MM_LIRC_DRIVER');
        if ($driver)
        {
            my $driver_file = "/etc/lirc.d/driver.conf/$driver";
            if ((-r $driver_file) && (open(FILE, '<', $driver_file)))
            {
                while (<FILE>)
                {
                    chomp;
                    /^$name='([^']*)'$/ && do { $auto = $1; };
                }
                close(FILE);
            }
        }
        return $auto;
    },
    value_none     => ''
};
$var_list{'MM_LIRC_KERNEL_MODULE_OPTIONS'} =
{
    prerequisite   => ['MM_LIRC_DRIVER'],
    value_default  => 'auto',
    value_valid    => 'auto|none|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my $auto = '';
       
        my $driver = $minimyth->var_get('MM_LIRC_DRIVER');
        if ($driver)
        {
            my $driver_file = "/etc/lirc.d/driver.conf/$driver";
            if ((-r $driver_file) && (open(FILE, '<', $driver_file)))
            {
                while (<FILE>)
                {
                    chomp;
                    /^$name='([^']*)'$/ && do { $auto = $1; };
                }
                close(FILE);
            }
        }
        return $auto;
    },
    value_none     => '',
};
$var_list{'MM_LIRC_IREXEC_ENABLED'} =
{
    value_default  => 'auto',
    value_valid    => 'auto|no|yes'
};
$var_list{'MM_LIRC_SLEEP_ENABLED'} =
{
    value_default  => 'yes',
    value_valid    => 'no|yes'
};
$var_list{'MM_LIRC_WAKEUP_ENABLED'} =
{
    value_default  => 'yes',
    value_valid    => 'no|yes'
};
$var_list{'MM_LIRC_FETCH_LIRCD_CONF'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {name_remote => '/lircd.conf',
                       name_local  => '/etc/lircd.conf'}
};
$var_list{'MM_LIRC_FETCH_LIRCRC'} =
{
    value_default  => 'no',
    value_valid    => 'no|yes',
    value_file     => 'yes',
    file           => {name_remote => '/lircrc',
                       name_local  => '/etc/lircrc'}
};
$var_list{'MM_LIRC_DEVICE_LIST'} =
{
    prerequisite   => ['MM_LIRC_AUTO_ENABLED', 'MM_LIRC_DEVICE_BLACKLIST', 'MM_LIRC_DEVICE', 'MM_LIRC_FETCH_LIRCD_CONF'],
    value_default  => 'auto',
    value_valid    => 'auto|.+',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        my @device_list;

        # If the manual LIRC driver is not 'irtrans',
        # then create LIRC device list.
        # If the manually configured LIRC driver is 'irtrans',
        # then the IRTrans server will act as the LIRC device
        # so no LIRC device list is created.
        if ($minimyth->var_get('MM_LIRC_DRIVER') ne 'irtrans')
        {
            my $device     = $minimyth->device_canonicalize($minimyth->var_get('MM_LIRC_DEVICE'));
            my $driver     = $minimyth->var_get('MM_LIRC_DRIVER');
            my $lircd_conf = q(/etc/lircd.conf);
            if (($device) && ($driver))
            {
                push(@device_list, "$device,$driver,$lircd_conf");
            }
            if ($minimyth->var_get('MM_LIRC_AUTO_ENABLED') eq 'yes')
            {
                foreach my $item (@{$minimyth->detect_state_get('lirc')})
                {
                    my $device =     $minimyth->device_canonicalize($item->{'device'});
                    my $driver     = $item->{'driver'};
                    my $lircd_conf = $item->{'lircd_conf'};
                    if ((! $lircd_conf) || ($minimyth->var_get('MM_LIRC_FETCH_LIRCD_CONF') eq 'yes'))
                    {
                        $lircd_conf = q(/etc/lircd.conf);
                    }
                    if (($device) && ($driver))
                    {
                        push(@device_list, "$device,$driver,$lircd_conf");
                    }
                }
            }
            # Remove any dumplicates.
            {
                my $prev = '';
                @device_list = grep($_ ne $prev && (($prev) = $_), sort(@device_list));
            }
        }

        if ($minimyth->var_get('MM_LIRC_DEVICE_BLACKLIST'))
        {
            my @blacklist = ();
            foreach my $item (split(/  +/, $minimyth->var_get('MM_LIRC_DEVICE_BLACKLIST')))
            {
                if ($item)
                {
                    push(@blacklist, $minimyth->device_canonicalize($item));
                }
            }
            my $blacklist_filter = join('|', @blacklist);
            @device_list = grep(! /^($blacklist_filter),.+$/, @device_list);
        }

        return join(' ', @device_list);
    }
};
$var_list{'MM_LIRC_KERNEL_MODULE_LIST'} =
{
    prerequisite   => ['MM_LIRC_KERNEL_MODULE', 'MM_LIRC_KERNEL_MODULE_OPTIONS'],
    value_clean    => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        $minimyth->var_set($name, 'auto');

        return 1;
    },
    value_default  => 'auto',
    value_valid    => 'auto',
    value_auto     => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        return $minimyth->var_get('MM_LIRC_KERNEL_MODULE');
    },
    extra          => sub
    {
        my $minimyth = shift;
        my $name     = shift;

        # Create a modprobe configuration file with the LIRC kernel module options.
        my $kernel_module         = $minimyth->var_get('MM_LIRC_KERNEL_MODULE');
        my $kernel_module_options = $minimyth->var_get('MM_LIRC_KERNEL_MODULE_OPTIONS');
        if (($kernel_module) && ($kernel_module_options))
        {
            my $modprobe_file = "/etc/modprobe.d/init::conf::MM_LIRC.conf";
            if ((open(FILE, '>', $modprobe_file)))
            {
                print FILE "# autogenerated by init::conf::MM_LIRC\n";
                print FILE "options $kernel_module $kernel_module_options\n";
            }
            else
            {
                return 0;
            }
        }
        return 1;
    }
};

1;
