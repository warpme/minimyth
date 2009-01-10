#!/usr/bin/perl
################################################################################
# conf
################################################################################
package init::conf;

use strict;
use warnings;

use Cwd ();
use File::Basename ();
use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    my $dir = Cwd::abs_path(File::Basename::dirname(__FILE__));

    # This is a hack for testing that should never get invoked during normal boot.
    unlink('/etc/conf.d/dhcp.override') if (-e '/etc/conf.d/dhcp.override');
    unlink('/etc/conf.d/minimyth')      if (-e '/etc/conf.d/minimyth');

    # Read core and dhcp configuration files, which are included in '/etc/conf'.
    $minimyth->var_clear();
    $minimyth->var_load({ 'file' => '/etc/conf' });

    $minimyth->message_output('info', "fetching configuration file  ...");

    # Determine current boot directory location.
    $self->_run($minimyth, 'MM_MINIMYTH_BOOT_URL');

    # Using local configuration files, so there should be a '/minimyth' directory.
    if ($minimyth->var_get('MM_MINIMYTH_BOOT_URL') eq 'file:/minimyth/')
    {
        while (! -e '/minimyth')
        {
            $minimyth->message_output('info', "waiting for directory /minimyth to mount ...");
            sleep 1;
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
            }
        }
        close(FILE);
    }

    # Fetch and run 'minimyth.pm'.
    $self->_run($minimyth, 'MM_MINIMYTH_FETCH_MINIMYTH_PM');
    if ($minimyth->var_get('MM_MINIMYTH_FETCH_MINIMYTH_PM') eq 'yes')
    {
        $minimyth->message_output('info', "fetching configuration package ...");
        unlink('/etc/minimyth.d/minimyth.pm');
        $minimyth->confro_get('/minimyth.pm', '/etc/minimyth.d/minimyth.pm');
        if (! -e '/etc/minimyth.d/minimyth.pm')
        {
            $minimyth->message_output('err', "failed to fetch 'minimyth.pm' file.");
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
                init::minimyth->start($minimyth);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
            }
        } 
    }

    # Enable configuration auto-detection udev rules.
    if (opendir(DIR, '/lib/udev/rules.d'))
    {
        foreach (grep(s/^(05-minimyth-.*\.rules)\.disabled$/$1/, (readdir(DIR))))
        {
            rename("/lib/udev/rules.d/$_.disabled", "/lib/udev/rules.d/$_");
        }
        closedir(DIR);
    }

    # Trigger udev with the additional udev rules that handle configuration auto-detection.
    system(qq(/sbin/udevadm trigger));
    system(qq(/sbin/udevadm settle --timeout=60));

    # Process the DHCP override configuration variables
    # so that they are available to the DHCP client.
    $self->_run($minimyth, 'MM_DHCP_.*');
    $minimyth->var_save({ 'file' => '/etc/conf.d/dhcp.override', 'filter' => 'MM_DHCP_.*' });

    # Start the DHCP client now that we have created the DHCP override variables file.
    $minimyth->package_require(q(init::dhcp));
    if ($minimyth->package_member_require(q(init::dhcp), q(start)))
    {
        eval
        {
            init::dhcp->start($minimyth);
        };
        if ($@)
        {
            $minimyth->message_output('err', qq($@));
        }
    }

    $minimyth->message_output('info', "processing configuration file ...");
    $minimyth->var_clear();
    $minimyth->var_load({ 'file' => '/etc/minimyth.d/minimyth.conf' });
    $self->_run($minimyth);
    $minimyth->var_save();

    # If there are any errors, then do not continue
    if ((-e '/var/log/minimyth.err.log') && (open(FILE, '<', '/var/log/minimyth.err.log')))
    {
        my $conf_error = 0;
        while (<FILE>)
        {
            $conf_error = 1;
            last;
        }
        close(FILE);
        if ($conf_error != 0)
        {
            $minimyth->message_output('err', "check '/var/log/minimyth.err.log' for further details.");
            return 0;
        }
    }

    return 1;
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

sub _run
{
    my $self     = shift;
    my $minimyth = shift;
    my $filter   = shift || 'MM_.*';

    my %var_list;

    # Get the variable handlers from each of the variable group packages in the MM directory,
    # discarding the variable handlers for variables that do not match the filter.
    my $dir = Cwd::abs_path(File::Basename::dirname(__FILE__)) . '/conf';

    if ((-d $dir) && (opendir(DIR, $dir)))
    {
        foreach (grep(s/^(MM_.*)\.pm$/$1/ && (-f "$dir/$_.pm"), readdir(DIR)))
        {
            my $group = __PACKAGE__ . '::' . $_;

            $minimyth->package_require($group);

            if ($minimyth->package_member_require($group, q(var_list)))
            {
                my $group_var_list = undef;
                eval
                {
                    $group_var_list = $group->var_list();
                };
                if ($@)
                {
                    $minimyth->message_output('err', qq($@));
                    return 0;
                }
                foreach (grep( /^$filter$/, keys %{$group_var_list}))
                {
                    $var_list{$_} = $group_var_list->{$_};
                }
            }
        }
        closedir(DIR);
    }

    # Make sure that all variables (re)initialize.
    foreach (keys %var_list)
    {
        $var_list{$_}->{'complete'} = 0;
    }

    # Run variable initialization handler for MM_MINIMYTH_BOOT_URL because it is needed when fetching files.
    $self->_run_var($minimyth, \%var_list, 'MM_MINIMYTH_BOOT_URL');

    # Run the variable initialization handlers for each variable.
    foreach (keys %var_list)
    {
        $self->_run_var($minimyth, \%var_list, $_);
    }

    return 1;
}

sub _run_var
{
    my $self     = shift;
    my $minimyth = shift;
    my $var_list = shift;
    my $var_name = shift;

    my $var = $var_list->{$var_name};

    my $prerequisite   = $var->{'prerequisite'};
    my $value_clean    = $var->{'value_clean'};
    my $value_default  = $var->{'value_default'};
    my $value_valid    = $var->{'value_valid'};
    my $value_obsolete = $var->{'value_obsolete'};
    my $value_auto     = $var->{'value_auto'};
    my $value_none     = $var->{'value_none'};
    my $value_file     = $var->{'value_file'};
    my $file           = $var->{'file'};
    my $extra          = $var->{'extra'};

    # Check whether or not it has been processed.
    if (($var->{'complete'}) && ($var->{'complete'} == 1))
    {
        return 1;
    }

    # Process prerequisites.
    if ($prerequisite)
    {
        # Convert function pointer to its return value.
        if (ref($prerequisite) eq 'CODE')
        {
            eval
            {
                $prerequisite = &{$prerequisite}($minimyth, $var_name); 
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                return 0;
            }
        }
        # Convert non-array pointer (i.e. scaler) to an array pointer.
        if (ref($prerequisite) ne 'ARRAY')
        {
            $prerequisite = [ $prerequisite ];
        }
        # Process prerequisites.
        foreach (@{$prerequisite})
        {
            my $filter = $_;
            foreach (grep(/^$filter$/, (keys %{$var_list})))
            {
                $self->_run_var($minimyth, $var_list, $_);
            }
        }
    }

    # If the variable is not defined, then set it to an empty string.
    if (! defined $minimyth->var_get($var_name))
    {
        $minimyth->var_set($var_name, '');
    }

    # Clean value.
    if (defined $value_clean)
    {
        &{$value_clean}($minimyth, $var_name);
    }

    # Process default value.
    if (defined $value_default)
    {
        if ($minimyth->var_get($var_name) eq '')
        {
            # Convert function pointer to its return value.
            if (ref($value_default) eq 'CODE')
            {
                eval
                {
                    $value_default = &{$value_default}($minimyth, $var_name); 
                };
                if ($@)
                {
                    $minimyth->message_output('err', qq($@));
                    return 0;
                }
            }
            # Set variable to its default value.
            $minimyth->var_set($var_name, $value_default);
        }
    }

    # Check whether or not the value is valid.
    if (defined $value_valid)
    {
        # Convert function pointer to its return value.
        if (ref($value_valid) eq 'CODE')
        {
            eval
            {
                $value_valid = &{$value_valid}($minimyth, $var_name);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                return 0;
            }
        }
        # Convert non-array pointer (i.e. scaler) to an array pointer.
        if (ref($value_valid) ne 'ARRAY')
        {
            $value_valid = [ $value_valid ];
        }
        # Check whether or not the value is valid.
        my $valid = 0;
        foreach (@{$value_valid})
        {
            if ($minimyth->var_get($var_name) =~ m/^($_)$/)
            {
                $valid = 1;
            }
        }
        if ($valid == 0)
        {
            $minimyth->message_output('err', qq($var_name=') . $minimyth->var_get($var_name) . qq(' is not valid.));

            # Replace the invalid value with the default value,
            # so that dependent variables will get a valid value.
            $minimyth->var_set($var_name, '');
            if (defined $value_default)
            {
                if ($minimyth->var_get($var_name) eq '')
                {
                    # Convert function pointer to its return value.
                    if (ref($value_default) eq 'CODE')
                    {
                        eval
                        {
                            $value_default = &{$value_default}($minimyth, $var_name); 
                        };
                        if ($@)
                        {
                            $minimyth->message_output('err', qq($@));
                            return 0;
                        }
                    }
                    # Set variable to its default value.
                    $minimyth->var_set($var_name, $value_default);
                }
            }
        }
    }

    # Check whether or not the value is obsolete.
    if (defined $value_obsolete)
    {
        # Convert function pointer to its return value.
        if (ref($value_obsolete) eq 'CODE')
        {
            eval
            {
                $value_obsolete = &{$value_obsolete}($minimyth, $var_name);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                return 0;
            }
        }
        # Convert non-array pointer (i.e. scaler) to an array pointer.
        if (ref($value_obsolete) ne 'ARRAY')
        {
            $value_obsolete = [ $value_obsolete ];
        }
        # Check whether or not the value is obsolete.
        my $obsolete = 0;
        foreach (@{$value_obsolete})
        {
            if ($minimyth->var_get($var_name) =~ m/^($_)$/)
            {
                $obsolete = 1;
            }
        }
        if ($obsolete == 1)
        {
            $minimyth->message_output('err', qq('minimyth.conf' is out of date. $var_name=') . $minimyth->var_get($var_name) . qq(' is obsolete.));
        }
    }

    # Process special value 'auto'.
    if ((defined $value_auto) && ($minimyth->var_get($var_name) eq 'auto'))
    {
        # Convert function pointer to its return value.
        if (ref($value_auto) eq 'CODE')
        {
            eval
            {
                $value_auto = &{$value_auto}($minimyth, $var_name);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                return 0;
            }
        }
        # Set variable to its auto value.
        $minimyth->var_set($var_name, $value_auto);
    }

    # Process special value 'none'.
    if ((defined $value_none) && ($minimyth->var_get($var_name) eq 'none'))
    {
        # Convert function pointer to its return value.
        if (ref($value_none) eq 'CODE')
        {
            eval
            {
                $value_none = &{$value_none}($minimyth, $var_name);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                return 0;
            }
        }
        # Set variable to its none value.
        $minimyth->var_set($var_name, $value_none);
    }

    # Fetch associated file(s).
    if ((defined $value_file) && (defined $file))
    {
        # Convert function pointer to its return value.
        if (ref($value_file) eq 'CODE')
        {
            eval
            {
                $value_file = &{$value_file}($minimyth, $var_name);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                return 0;
            }
        }
        if (ref($file) eq 'CODE')
        {
            eval
            {
                $file = &{$file}($minimyth, $var_name);
            };
            if ($@)
            {
                $minimyth->message_output('err', qq($@));
                return 0;
            }
        }
        # Convert non-array pointer (i.e. hash pointer) to an array pointer.
        if (ref($file) ne 'ARRAY')
        {
            $file = [ $file ];
        }
        if ($minimyth->var_get($var_name) =~ /^$value_file$/)
        {
            foreach (@{$file})
            {
                my $name_remote = $_->{'name_remote'};
                my $name_local  = $_->{'name_local'};
                my $mode_local  = $_->{'mode_local'}  || '0644' ;
                unlink($name_local);
                my $result = $minimyth->confro_get($name_remote, $name_local);
                if (! -e $name_local)
                {
                    $minimyth->message_log('err', qq(failed to fetch MiniMyth read-only configuration file ') . $name_remote . qq('));
                }
                else
                {
                    $minimyth->message_log('info', qq(fetched MiniMyth read-only configuration file ') . $name_remote . qq('));
                    $minimyth->message_log('info', qq(  by fetching ') . $result . qq('));
                    $minimyth->message_log('info', qq(  to local file ') . $name_local . qq('.));
                    chmod(oct($mode_local), $name_local);
                }
            }
        }
    }

    # Run extra sub-routine.
    if (defined $extra)
    {
        &{$extra}($minimyth, $var_name);
    }

    $var->{'complete'} = 1;

    return 1;
}

1;
