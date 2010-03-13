################################################################################
# init::conf::base
################################################################################
package init::conf::base;

use strict;
use warnings;

use Cwd ();
use File::Basename ();
use File::Path ();
use MiniMyth ();

sub list_run
{
    my $self     = shift;
    my $minimyth = shift;
    my $filter   = shift || 'MM_.*';

    my $success = 1;

    my %var_list;

    # Get the variable handlers from each of the variable group packages in the MM directory.
    my $dir = Cwd::abs_path(File::Basename::dirname(__FILE__));

    if ((-d $dir) && (opendir(DIR, $dir)))
    {
        foreach (grep(s/^(MM_.*)\.pm$/$1/ && (-f "$dir/$_.pm"), readdir(DIR)))
        {
#            my $group = 'init::conf::' . $_;
            my $group = __PACKAGE__;
            $group =~ s/[^:]+$//;
            $group .= $_;

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
                    $success = 0;
                    return $success;
                }
                foreach (keys %{$group_var_list})
                {
                    $var_list{$_} = $group_var_list->{$_};
                }
            }
        }
        closedir(DIR);
    }

    # Make sure that all variables that match the filter (re)initialize.
    foreach (grep( /^$filter$/, keys %var_list))
    {
        $var_list{$_}->{'complete'} = 0;
    }

    # Run variable initialization handler for MM_MINIMYTH_BOOT_URL because it is needed when fetching files.
    $self->item_run($minimyth, \%var_list, 'MM_MINIMYTH_BOOT_URL');

    # Run the variable initialization handlers for each variable that matches the filter .
    foreach (grep( /^$filter$/, keys %var_list))
    {
        $self->item_run($minimyth, \%var_list, $_) || ($success = 0);
    }

    return $success;
}

sub item_run
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

    my $success = 1;

    # Check whether or not it has been processed.
    if (($var->{'complete'}) && ($var->{'complete'} == 1))
    {
        return $success;
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
                $success = 0;
                return $success;
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
                $self->item_run($minimyth, $var_list, $_) || ($success = 0);
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
        &{$value_clean}($minimyth, $var_name) || ($success = 0);
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
                    $success = 0;
                    return $success;
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
                $success = 0;
                return $success;
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
            $success = 0;

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
                            $success = 0;
                            return $success;
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
                $success = 0;
                return $success;
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
            $success = 0;
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
                $success = 0;
                return $success;
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
                $success = 0;
                return $success;
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
                $success = 0;
                return $success;
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
                $success = 0;
                return $success;
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
 
                if (-e $name_local)
                {
                    File::Path::rmtree($name_local);
                }
                my $result = $minimyth->confro_get($name_remote, $name_local);
                if (! -e $name_local)
                {
                    $minimyth->message_output('err', qq(failed to fetch MiniMyth read-only configuration file ') . $name_remote . qq('));
                    $success = 0;
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
        &{$extra}($minimyth, $var_name) || ($success = 0);
    }

    $var->{'complete'} = 1;

    return $success;
}

1;
