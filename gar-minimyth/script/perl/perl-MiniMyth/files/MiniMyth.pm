package MiniMyth;

use strict;
use warnings;
use feature "switch";

require DBD::mysql;
require DBI;
require File::Basename;
require File::Copy;
require File::Find;
require File::Path;
require File::Spec;
require Net::Telnet;
require Sys::Hostname;
use     WWW::Curl::Easy;

sub new
{
    my $proto = shift;

    my $class = ref($proto) || $proto;

    my $self;
    $self->{'conf_variable'} = undef;
    $self->{'mythdb_handle'} = undef;

    bless($self, $class);

    return $self;
}

sub DESTROY
{
    my $self = shift;

    if (defined $self->{'mythdb_handle'})
    {
        $self->{'mythdb_handle'}->disconnect;
    }
}

#===============================================================================
# general functions.
#===============================================================================
sub command_run()
{
    my $self    = shift;
    my $command = shift;

    my $return = 1;

    my $log_file = File::Spec->devnull;
    if ($self->var_get('MM_DEBUG') eq 'yes')
    {
        $log_file = '/var/log/minimyth.log';
        if (! -e $log_file)
        {
            my $log_dir = File::Basename::dirname($log_file);
            if (! -e $log_dir)
            {
                File::Path::mkpath($log_dir);
            }
            if (-w $log_dir)
            {
                open(FILE, '>', $log_file);
                chmod(0666, $log_file);
                close(FILE);
            }
        }
    }

    open(STDERR, '>', 'STDOUT');
    if (-e $log_file)
    {
        open(STDOUT, '>>', $log_file);
    }
    print qq( --- execution start: $command\n);
    system(qq($command)) || ($return = 1);
    print qq( --- execution end:   $command\n);
    close(STDOUT);
    close(STDERR);

    return $return;
}

#===============================================================================
# Message output functions.
#===============================================================================
sub message_output
{
    my $self    = shift;
    my $level   = shift;
    my $message = shift;

    if ($self->splash_running_test)
    {
        system(qq(/usr/bin/logger    -t minimyth -p local0.$level "$message"));
        $self->splash_message_output($message);
    }
    else
    {
        system(qq(/usr/bin/logger -s -t minimyth -p local0.$level "$message"));
    }

    if (($level eq 'err') || ($level eq 'warn'))
    {
        my $log_file = "/var/log/minimyth.$level.log";
        if (! -e $log_file)
        {
            my $log_dir = File::Basename::dirname($log_file);
            if (! -e $log_dir)
            {
                File::Path::mkpath($log_dir);
            }
            if (-w $log_dir)
            {
                open(FILE, '>', $log_file);
                chmod(0666, $log_file);
                close(FILE);
            }
        }
        if (-e $log_file)
        {
            open(FILE, '>>', $log_file);
            print FILE $message . "\n";
            close(FILE);
        }
        $self->splash_command(qq(log $message));
    }
}

sub message_log
{
    my $self    = shift;
    my $level   = shift;
    my $message = shift;

    system(qq(/usr/bin/logger -t minimyth -p local0.$level "$message"));
}

#===============================================================================
# MiniMyth configuration variable functions.
#===============================================================================
sub var_clear
{
    my $self = shift;

    if (defined $self->{'conf_variable'})
    {
        undef $self->{'conf_variable'};
    }
}

sub var_load
{
    my $self = shift;
    my $args = shift;

    my $conf_file   = ($args && $args->{'file'}  ) || '';
    my $conf_filter = ($args && $args->{'filter'}) || 'MM_.*';

    my %conf_variable;

    if ((exists($self->{'conf_variable'})) && (defined($self->{'conf_variable'})))
    {
        foreach (keys %{$self->{'conf_variable'}})
        {
            $conf_variable{$_} = $self->{'conf_variable'}->{$_};
        }
    }

    my $shell_command = ". /etc/conf";
    $shell_command = $shell_command . " ; . /lib/minimyth/functions";
    if ($conf_file)
    {
        if (-r $conf_file)
        {
            $shell_command = $shell_command . " ; . $conf_file";
        }
        else
        {
            $self->message_log('warn', "var_load: file '$conf_file' does not exist.");
        }
    }
    $shell_command = $shell_command . " ; set";

    if ((-x '/bin/sh') && (open(FILE, '-|', qq(/bin/sh -c '$shell_command'))))
    {
        foreach (grep(/^$conf_filter$/, (<FILE>)))
        {
            chomp;
            if (/^([^=]+)='(.*)'$/)
            {
                $conf_variable{$1} = $2;
            }
        }
        close(FILE);
    }

    $self->{'conf_variable'} = \%conf_variable;
}

sub var_save
{
    my $self = shift;
    my $args = shift;

    my $conf_file   = ($args && $args->{'file'}  ) || '/etc/conf.d/minimyth';
    my $conf_filter = ($args && $args->{'filter'}) || 'MM_.*';

    # If the variables have not been loaded and the processed variables file exists, then autoload variables.
    (! defined $self->{'conf_variable'}) && (-e '/etc/conf.d/minimyth') && $self->var_load();

    (defined $self->{'conf_variable'}) || die 'MiniMyth::var_save: MiniMyth configuration variables have not been loaded.';

    File::Path::mkpath(File::Basename::dirname("$conf_file"));
    unlink("$conf_file.$$");
    if (open(FILE, '>', "$conf_file.$$"))
    {
        chmod(0644, "$conf_file.$$");
        foreach (sort keys %{$self->{'conf_variable'}})
        {
            chomp;
            if (/^$conf_filter$/)
            {
                print FILE $_ . "=" . "'" . $self->{'conf_variable'}->{$_} . "'" . "\n";
            }
        }
        close(FILE);
        unlink("$conf_file");
	rename("$conf_file.$$", "$conf_file");
    }
}

sub var_list
{
    my $self = shift;
    my $args = shift;

    # If the variables have not been loaded and the processed variables file exists, then autoload variables.
    (! defined $self->{'conf_variable'}) && (-e '/etc/conf.d/minimyth') && $self->var_load();

    (defined $self->{'conf_variable'}) || die 'MiniMyth::var_save: MiniMyth configuration variables have not been loaded.';

    my $conf_filter = ($args && $args->{'filter'}) || 'MM_.*';

    my @list = grep(/^$conf_filter$/, (keys %{$self->{'conf_variable'}}));

    return \@list;
}


sub var_get
{
    my $self  = shift;
    my $name  = shift;

    # If the variables have not been loaded and the processed variables file exists, then autoload variables.
    (! defined $self->{'conf_variable'}) && (-e '/etc/conf.d/minimyth') && $self->var_load();

    (defined $self->{'conf_variable'}) || die 'MiniMyth::var_get: MiniMyth configuration variables have not been loaded.';

    return $self->{'conf_variable'}->{$name};
}

sub var_set
{
    my $self  = shift;
    my $name  = shift;
    my $value = shift;

    # If the variables have not been loaded and the processed variables file exists, then autoload variables.
    (! defined $self->{'conf_variable'}) && (-e '/etc/conf.d/minimyth') && $self->var_load();

    (defined $self->{'conf_variable'}) || die 'MiniMyth::var_set: MiniMyth configuration variables have not been loaded.';

    $self->{'conf_variable'}->{$name} = $value;
}

sub var_exists
{
    my $self  = shift;
    my $name  = shift;

    (! defined $self->{'conf_variable'}) && (-e '/etc/conf.d/minimyth') && $self->var_load();

    (defined $self->{'conf_variable'}) || die 'MiniMyth::var_set: MiniMyth configuration variables have not been loaded.';

    if (defined $self->{'conf_variable'}->{$name})
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

#===============================================================================
# Hardware autodetection functions.
#===============================================================================
sub detect_state_get
{
    my $self     = shift;
    my $group    = shift;
    my $instance = shift;
    my $field    = shift;

    my %map;
    $map{'audio'}   = [ 'card_number' , 'device_number' ];
    $map{'backend'} = [ 'enabled'];
    $map{'lcdproc'} = [ 'device' , 'driver'];
    $map{'lirc'}    = [ 'device' , 'driver'];
    $map{'x'}       = [ 'driver' ];

    my @state;

    my $state_dir = "/var/cache/minimyth/detect/$group";
    if ((-d $state_dir) && (opendir(DIR, $state_dir)))
    {
        foreach (readdir(DIR))
        {
            if ((! /^\./) && (-f "$state_dir/$_") && (open(FILE, '<', "$state_dir/$_")))
            {
                while (<FILE>)
                {
                    chomp;
                    my %record;
                    my @record_raw = split(/,/, $_);
                    for (my $index = 0 ; $index <= $#record_raw ; $index++)
                    {
                        $record{$map{$group}->[$index]} = $record_raw[$index];
                    }
                    push(@state, \%record);
                }
                close(FILE);
            }
        }
        closedir(DIR);
    }

    if (@state)
    {
        if (! defined $instance)
        {
            return \@state;
        }
        else
        {
            if (($instance >= 0) && ($instance <= $#state))
            {
                if (! defined $field)
                {
                    return $state[$instance];
                }
                else
                {
                    if ($state[$instance]->{$field})
                    {
                        return $state[$instance]->{$field};
                    }
                }
            }
        }
    }
}

#===============================================================================
# splash screen functions
#===============================================================================
my $var_splash_command      = '/usr/sbin/fbsplashd';
my $var_splash_command_dir  = File::Basename::dirname($var_splash_command);
my $var_splash_command_base = File::Basename::basename($var_splash_command);
my $var_splash_fifo         = '/lib/splash/cache/.splash';
my $var_splash_fifo_dir     = File::Basename::dirname($var_splash_fifo);
my $var_splash_fifo_base    = File::Basename::basename($var_splash_fifo);
my $var_splash_progress_val = 1;
my $var_splash_progress_max = 1;

sub splash_running_test
{
    my $self = shift;

    my $devnull = File::Spec->devnull;
    if ((system(qq(/bin/pidof $var_splash_command_base $devnull 2>&1)) == 0) && (-e $var_splash_fifo))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

sub splash_init
{
    my $self = shift;
    my $type = shift || '';

    my $enable = 'yes';

    # Disable splash screen when more than kernel critical messages are logged to the console.
    # That is when the loglevel is greater than 3.
    if ($enable eq 'yes')
    {
        if (open(FILE, '<', '/proc/sys/kernel/printk'))
        {
            my $LOGLEVEL;
            while (<FILE>)
            {
                chomp;
                ($LOGLEVEL) = split(/[[:cntrl:]]|[ ]/, $_);
            }
            close(FILE);
            ($LOGLEVEL eq '')                    && ($enable = 'no');
            ($LOGLEVEL ne '') && ($LOGLEVEL > 3) && ($enable = 'no');
        }
    }

    # Disable splash screen when there is no framebuffer device.
    if ($enable eq 'yes')
    {
        (! -e '/dev/fb0') && ($enable = 'no');
    }

    # Disable splash screen when the video resolution is not compatible.
    # That is when the resolution is not 640x480 or color depth is less than 16.
    if ($enable eq 'yes')
    {
        if (open(FILE, '-|', '/usr/sbin/fbset'))
        {
            while (<FILE>)
            {
                chomp;
                if (/geometry/)
                {
                    my (undef, $XRES, $YRES, $VXRES, $VYRES, $DEPTH) = split(/ /, $_);
                    ($XRES  eq '') &&                    ($enable = 'no');
                    ($YRES  eq '') &&                    ($enable = 'no');
                    ($VXRES eq '') &&                    ($enable = 'no');
                    ($VYRES eq '') &&                    ($enable = 'no');
                    ($DEPTH eq '') &&                    ($enable = 'no');
                    ($XRES  ne '') && ($XRES  != 640) && ($enable = 'no');
                    ($YRES  ne '') && ($YRES  != 480) && ($enable = 'no');
                    ($VXRES ne '') && ($VXRES != 640) && ($enable = 'no');
                    ($VYRES ne '') && ($VYRES != 480) && ($enable = 'no');
                    ($DEPTH ne '') && ($DEPTH <   16) && ($enable = 'no');
                }
            }
            close(FILE);
        }
        else
        {
            $enable = 'no';
        }
    }

    if ($enable eq 'yes')
    {
        my $message;
        given ($type)
        {
            when (/^bootup$/  ) { $message = 'starting system ...'     ; }
            when (/^shutdown$/) { $message = 'shutting down system ...'; }
            when (/^reboot$/  ) { $message = 'restarting system ...'   ; }
            default             { $message = ''                        ; }
        }
        $self->message_log('info', qq(starting splash screen));
        system(qq(/usr/bin/chvt 1));
        File::Path::mkpath($var_splash_fifo_dir, {mode => 0755});
        $self->splash_command('exit');
        system(qq($var_splash_command --theme="minimyth" --progress="0" --mesg="$message" --type="$type"));
        $self->splash_command('set mode silent');
        $self->splash_command('repaint');
    }

    $self->splash_progress_set(0, 1);

    return 1;
}

sub splash_halt
{
    my $self = shift;

    $self->message_log('info', qq(stopping splash screen));

    $self->splash_command('exit');

    return 1;
}

sub splash_command
{
    my $self    = shift;
    my $command = shift;

    if ($self->splash_running_test())
    {
        if (open(FILE, '>>', $var_splash_fifo))
        {
            print FILE $command . "\n";
            close(FILE);
        }
    }

    return 1;
}

sub splash_message_output
{
    my $self    = shift;
    my $message = shift;

    $self->splash_command(qq(set message $message));
    $self->splash_command('repaint');

    return 1;
}

sub splash_progress_set
{
    my $self         = shift;
    my $progress_val = shift;
    my $progress_max = shift;

    $var_splash_progress_val = $progress_val;
    $var_splash_progress_max = $progress_max;

    ($var_splash_progress_val > $var_splash_progress_max) && ($var_splash_progress_val = $var_splash_progress_max);

    my $progress = (65535 * $var_splash_progress_val) / $var_splash_progress_max;
    $self->splash_command(qq(progress $progress));
    $self->splash_command('repaint');

    return 1;
}

sub splash_progress_update
{
    my $self = shift;

    $var_splash_progress_val = $var_splash_progress_val + 1;
    ($var_splash_progress_val > $var_splash_progress_max) && ($var_splash_progress_val = $var_splash_progress_max);

    my $progress = (65535 * $var_splash_progress_val) / $var_splash_progress_max;
    $self->splash_command(qq(progress $progress));
    $self->splash_command('repaint');

    return 1;
}

#===============================================================================
# mythdb_* functions.
#===============================================================================
sub _mythdb_condition
{
    my $self      = shift;
    my $prefix    = shift;
    my $separator = shift;
    my $condition = shift;
    my $flag      = shift;

    my $flag_condition_hostname = 1;
    if (defined $flag)
    {
        if (exists $flag->{'condition_hostname'}) { $flag_condition_hostname = $flag->{'condition_hostname'}; }
    }

    my $result = '';

    if ($flag_condition_hostname == 1)
    {
        my $hostname = Sys::Hostname::hostname();
        if (! $result) { $result .= ' ' . $prefix    . ' '; }
        else           { $result .= ' ' . $separator . ' '; }
        $result = $result . qq(hostname="$hostname");
    }

    foreach (keys %{$condition})
    {
        if (! $result) { $result .= ' ' . $prefix    . ' '; }
        else           { $result .= ' ' . $separator . ' '; }
        $result = $result . qq($_="$condition->{$_}");
    }

    return $result;
}

sub mythdb_handle
{
    my $self = shift;

    if (! defined $self->{'mythdb_handle'})
    {
        my $mythdb_handle;

        my $dbhostname = $self->var_get('MM_MASTER_SERVER');
        my $dbdatabase = $self->var_get('MM_MASTER_DBNAME');
        my $dbusername = $self->var_get('MM_MASTER_DBUSERNAME');
        my $dbpassword = $self->var_get('MM_MASTER_DBPASSWORD');

        my $dsn = "DBI:mysql:database=$dbdatabase;host=$dbhostname";

        $mythdb_handle = DBI->connect($dsn, $dbusername, $dbpassword);

        $self->{'mythdb_handle'} = $mythdb_handle;
    }

    return $self->{'mythdb_handle'};
}

sub mythdb_x_delete
{
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $flag      = shift;

    my $query = qq(DELETE FROM $table) . $self->_mythdb_condition('WHERE', 'AND', $condition, $flag);

    $self->mythdb_handle->do($query);
}

sub mythdb_x_get
{
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $field     = shift;
    my $flag      = shift;

    my $query = qq(SELECT * FROM $table) . $self->_mythdb_condition('WHERE', 'AND', $condition, $flag);

    my $sth = $self->mythdb_handle->prepare($query);
    $sth->execute;
    my $result = $sth->fetchrow_hashref()->{$field};
    $sth->finish();

    return $result;
}

sub mythdb_x_print
{
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $flag      = shift;

    my $query = qq(SELECT * FROM $table) . $self->_mythdb_condition('WHERE', 'AND', $condition, $flag);

    my $sth = $self->mythdb_handle->prepare($query);
    $sth->execute;
    my @rows = ();
    while (my $row = $sth->fetchrow_hashref())
    {
        push(@rows, $row);
    }
    my @fields = ();
    foreach my $field (keys %{$rows[0]})
    {
        if ($field !~ /^hostname$/)
        {
            push(@fields, $field);
        }
    }
    my %lengths;
    foreach my $field (@fields)
    {
        $lengths{$field} = length($field);
    }
    foreach my $row (@rows)
    {
        foreach my $field (@fields)
        {
            if ($lengths{$field} < length($row->{$field}))
            {
                $lengths{$field} = length($row->{$field});
            }
        }
    }
    @rows = sort { uc($a->{$fields[0]}) cmp uc($b->{$fields[0]}) } @rows;
    sub field_print
    {
        my $value  = shift;
        my $pad    = shift;
        my $length = shift;

        print "|" . $pad . $value;
        for ( $length -= length($value) ; $length > 0 ; $length-- )
        {
            print $pad;
        }
        print $pad;
    }
    foreach my $field (@fields) { field_print('-'   , '-', $lengths{$field}); } print "|" . "\n";
    foreach my $field (@fields) { field_print($field, ' ', $lengths{$field}); } print "|" . "\n";
    foreach my $field (@fields) { field_print('-'   , '-', $lengths{$field}); } print "|" . "\n";
    foreach my $row (@rows)
    {
        foreach my $field (@fields) { field_print($row->{$field}, ' ', $lengths{$field}); } print "|" . "\n";
    }
    foreach my $field (@fields) { field_print('-'   , '-', $lengths{$field}); } print "|" . "\n";
    $sth->finish();
}

sub mythdb_x_set
{
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $field     = shift;
    my $value     = shift;
    my $flag      = shift;

    my $query_delete = qq(DELETE FROM $table)                     . $self->_mythdb_condition('WHERE', 'AND', $condition, $flag);
    my $query_insert = qq(INSERT INTO $table SET $field="$value") . $self->_mythdb_condition(',',     ',',   $condition, $flag);

    $self->mythdb_handle->do($query_delete);
    $self->mythdb_handle->do($query_insert);
}

sub mythdb_x_test
{
    my $self = shift;

    my $test = 0;

    if ($self->mythdb_handle)
    {
        $test = 1;
    }

    return $test;
}

sub mythdb_x_update
{
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $field     = shift;
    my $value     = shift;
    my $flag      = shift;

    my $query = qq(UPDATE $table SET $field="$value") . $self->_mythdb_condition('WHERE', 'AND', $condition, $flag);

    $self->mythdb_handle->do($query);
}

sub mythdb_jumppoints_delete
{
    my $self        = shift;
    my $destination = shift;

    if ($destination)
    {
        return $self->mythdb_x_delete('jumppoints', { 'destination' => $destination });
    }
    else
    {
        return $self->mythdb_x_delete('jumppoints', {});
    }
}

sub mythdb_jumppoints_print
{
    my $self        = shift;
    my $destination = shift;

    if ($destination)
    {
        return $self->mythdb_x_print('jumppoints', { 'destination' => $destination });
    }
    else
    {
        return $self->mythdb_x_print('jumppoints', {});
    }
}

sub mythdb_jumppoints_update
{
    my $self        = shift;
    my $destination = shift;
    my $keylist     = shift;

    return $self->mythdb_x_print('jumppoints', { 'destination' => $destination }, 'keylist', $keylist);
}

sub mythdb_jumppoints_get
{
    my $self  = shift;
    my $value = shift;

    return $self->mythdb_x_get('jumppoints', { 'value' => $value }, 'data');
}

sub mythdb_keybindings_delete
{
    my $self    = shift;
    my $context = shift;
    my $action  = shift;

    if    (($context) && ($action))
    {
        return $self->mythdb_x_delete('keybindings', { 'context' => $context, 'action' => $action });
    }
    elsif (($context))
    {
        return $self->mythdb_x_delete('keybindings', { 'context' => $context });
    }
    else
    {
        return $self->mythdb_x_delete('keybindings', {});
    }
}

sub mythdb_keybindings_print
{
    my $self    = shift;
    my $context = shift;
    my $action  = shift;

    if    (($context) && ($action))
    {
        return $self->mythdb_x_print('keybindings', { 'context' => $context, 'action' => $action });
    }
    elsif (($context))
    {
        return $self->mythdb_x_print('keybindings', { 'context' => $context });
    }
    else
    {
        return $self->mythdb_x_print('keybindings', {});
    }
}

sub mythdb_keybindings_update
{
    my $self    = shift;
    my $context = shift;
    my $action  = shift;
    my $keylist = shift;

    return $self->mythdb_x_update('keybindings', { 'context' => $context, 'action' => $action}, 'keylist', $keylist);
}

sub mythdb_music_playlists_print
{
    my $self  = shift;

    $self->mythdb_x_print('music_playlists', {});
}

sub mythdb_music_playlists_scope
{
    my $self          = shift;
    my $playlist_name = shift;
    my $scope         = shift;

    my $hostname = Sys::Hostname::hostname();

    my $query = '';
    if    ($scope eq 'local')
    {
        $query = qq(UPDATE music_playlists SET hostname="$hostname" WHERE playlist_name="$playlist_name");
    }
    elsif ($scope eq 'global')
    {
        $query = qq(UPDATE music_playlists SET hostname=""          WHERE playlist_name="$playlist_name");
    }
    $self->mythdb_handle->do($query);
}

sub mythdb_settings_delete
{
    my $self  = shift;
    my $value = shift;

    if ( $value ) { $self->mythdb_x_delete('settings', { 'value' => $value }); }
    else          { $self->mythdb_x_delete('settings', {});                    }
}

sub mythdb_settings_get
{
    my $self  = shift;
    my $value = shift;

    return $self->mythdb_x_get('settings', { 'value' => $value }, 'data');
}

sub mythdb_settings_print
{
    my $self  = shift;
    my $value = shift;

    if ( $value ) { $self->mythdb_x_print('settings', { 'value' => $value }); }
    else          { $self->mythdb_x_print('settings', {});                    }
}

sub mythdb_settings_set
{
    my $self  = shift;
    my $value = shift;
    my $data  = shift;

    $self->mythdb_x_set('settings', { 'value' => $value }, 'data', $data);
}

sub mythdb_settings_update
{
    my $self  = shift;
    my $value = shift;
    my $data  = shift;

    $self->mythdb_x_update('settings', { 'value' => $value }, 'data', $data);
}

sub mythfrontend_networkcontrol
{
    my $self    = shift;
    my $command = shift;

    my $port = $self->mythdb_settings_get('NetworkControlPort');

    my $prompt = '/\# $/';
    my $telnet = new Net::Telnet('Timeout' => '10',
                                 'Errmode' => 'return',
                                 'Host'    => 'localhost',
                                 'Port'    => $port,
                                 'Prompt'  => $prompt);
    if ($telnet->open())
    {
        $telnet->waitfor($prompt);
        my @lines = $telnet->cmd($command);
        $telnet->cmd('exit');
        $telnet->close;
        chomp @lines;
        return \@lines;
    }
}

#===============================================================================
# url_parse functions.
#===============================================================================
sub url_parse
{
    my $self = shift;
    my $url  = shift;

    # Parse the URL.
    my    ($protocol, undef, undef, $username, undef, $password, $server , $path   , undef, $query   , undef, $fragment)
        = ($1 || '' , $2   , $3   , $4 || '' , $5   , $6 || '' , $7 || '', $8 || '', $9   , $10 || '', $11  , $12 || '')
        if ($url =~ /^([^:]+):(\/\/(([^:@]*)?(:([^@]*))?\@)?([^\/]+))?([^?#]*)(\?([^#]*))?(\#(.*))?$/);

    return ($protocol, $username, $password, $server, $path, $query, $fragment);
}

#===============================================================================
# url_*_get functions.
#===============================================================================
sub url_get
{
    my $self       = shift;
    my $url        = shift;
    my $local_file = shift;

    # Parse the URL.
    my ($remote_protocol, undef, undef, $remote_server, $remote_file, undef, undef) = $self->url_parse($url);

    my $result = '';
    given ($remote_protocol)
    {
        when (/^confro$/) { $result = $self->url_confro_get($local_file, $remote_file, $remote_server); }
        when (/^confrw$/) { $result = $self->url_confrw_get($local_file, $remote_file, $remote_server); }
        when (/^dist$/  ) { $result = $self->url_dist_get(  $local_file, $remote_file, $remote_server); }
        when (/^file$/  ) { $result = $self->url_file_get(  $local_file, $remote_file, $remote_server); }
        when (/^http$/  ) { $result = $self->url_http_get(  $local_file, $remote_file, $remote_server); }
        when (/^hunt$/  ) { $result = $self->url_hunt_get(  $local_file, $remote_file, $remote_server); }
        when (/^tftp$/  ) { $result = $self->url_tftp_get(  $local_file, $remote_file, $remote_server); }
        default           { $self->message_log('err', qq(error: MiniMyth::url_get: protocol ') . $_ . qq(' is not supported.)); }
    }
    return $result;
}

sub url_confro_get
{
    my $self        = shift;
    my $local_file  = shift;
    my $remote_file = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $hostname = Sys::Hostname::hostname();
    my $remote_file_0 = undef;
    my $remote_file_1 = undef;

    if ($hostname)
    {
        $remote_file_0 = $remote_file;
        $remote_file_0 = 'conf/' . $hostname . '/' . $remote_file_0;
    }
    $remote_file_1 = $remote_file;
    $remote_file_1 = 'conf/' . 'default' . '/' . $remote_file_1;

    my $result = '';
    if (($result eq '') && (defined $remote_file_0))
    {
        my $url = $self->var_get('MM_MINIMYTH_BOOT_URL') . $remote_file_0;
        $result = $self->url_get($url, $local_file);
    }
    if (($result eq '') && (defined $remote_file_1))
    {
        my $url = $self->var_get('MM_MINIMYTH_BOOT_URL') . $remote_file_1;
        $result = $self->url_get($url, $local_file);
    }
    return $result;
}

sub url_confrw_get
{
    my $self        = shift;
    my $local_file  = shift;
    my $remote_file = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $hostname = Sys::Hostname::hostname();
    my $remote_file_0 = undef;

    if ($hostname)
    {
        $remote_file_0 = $remote_file;
        $remote_file_0 =~ s/\//+/;
        $remote_file_0 = 'conf-rw/' . $hostname . '+' . $remote_file_0;
    }

    my $result = '';
    if (($result eq '') && (defined $remote_file_0))
    {
        my $url = $self->var_get('MM_MINIMYTH_BOOT_URL') . $remote_file_0;
        $result = $self->url_get($url, $local_file);
    }
    return $result;
}

sub url_dist_get
{
    my $self        = shift;
    my $local_file  = shift;
    my $remote_file = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $remote_file_0 = undef;

    if ($self->var_get('MM_ROOTFS_IMAGE') ne '')
    {
        $remote_file_0 = $self->var_get('MM_ROOTFS_IMAGE');
        $remote_file_0 =~ s/\/+/\//g;
        $remote_file_0 =~ s/[^\/]+$//g;
        $remote_file_0 =~ s/\/$//g;
    }
    else
    {
        $remote_file_0 = '/minimyth-' . $self->var_get('MM_VERSION');
    }
    $remote_file_0 = $remote_file_0 . '/' . $remote_file;

    my $result = '';
    if (($result eq '') && (defined $remote_file_0))
    {
        my $url = $self->var_get('MM_MINIMYTH_BOOT_URL') . $remote_file_0;
        $result = $self->url_get($url, $local_file);
    }
    return $result;
}

sub url_file_get
{
    my $self        = shift;
    my $local_file  = shift;
    my $remote_file = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;

    my $local_dir = undef;

    $local_dir = $local_file;
    $local_dir =~ s/[^\/]*$//;
    $local_dir =~ s/\$//;

    my $result = '';

    File::Path::mkpath($local_dir, {mode => 0755});
    (-d $local_dir) or return $result;

    unlink $local_file;
    File::Copy::copy($remote_file, $local_file) and $result = 'file:' . $remote_file;
    if ($result eq '')
    {
        unlink $local_file;
    }
    return $result;
}

sub url_http_get
{
    my $self          = shift;
    my $local_file    = shift;
    my $remote_file   = shift;
    my $remote_server = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $local_dir = undef;

    $local_dir = $local_file;
    $local_dir =~ s/[^\/]*$//;
    $local_dir =~ s/\$//;

    my $result = '';

    File::Path::mkpath($local_dir, {mode => 0755});
    (-d $local_dir) or return $result;

    unlink $local_file;
    my $url = 'http://' . $remote_server . '/' . $remote_file;
    open(my $OUT_FILE, '>', $local_file) || do { return $result; };
    chmod(0600, $local_file);
    my $curl = new WWW::Curl::Easy;
    $curl->setopt(CURLOPT_VERBOSE, 0);
    $curl->setopt(CURLOPT_URL, $url);
    $curl->setopt(CURLOPT_WRITEDATA, $OUT_FILE);
    my $retcode = $curl->perform;
    close($OUT_FILE);
    if ($retcode == 0)
    {
        $result = $url;
    }
    else
    {
        unlink $local_file;
        $result = ''
    }
    return $result;
}

sub url_hunt_get
{
    my $self        = shift;
    my $local_file  = shift;
    my $remote_file = shift;

    my $result = '';
    if ($result eq '')
    {
        $result = $self->url_dist_get($local_file, $remote_file);
    }
    if ($result eq '')
    {
        $result = $self->url_confro_get($local_file, $remote_file);
    }
    return $result;
}

sub url_tftp_get
{
    my $self          = shift;
    my $local_file    = shift;
    my $remote_file   = shift;
    my $remote_server = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $local_dir = undef;

    $local_dir = $local_file;
    $local_dir =~ s/[^\/]*$//;
    $local_dir =~ s/\$//;

    my $result = '';

    File::Path::mkpath($local_dir, {mode => 0755});
    (-d $local_dir) or return $result;

    unlink $local_file;
    my $url = 'tftp://' . $remote_server . '/' . $remote_file;
#    open(my $OUT_FILE, '>', $local_file) || do { return $result; };
#    chmod(0600, $local_file);
#    my $curl = new WWW::Curl::Easy;
#    $curl->setopt(CURLOPT_URL, $url);
#    $curl->setopt(CURLOPT_WRITEDATA, $OUT_FILE);
#    my $retcode = $curl->perform;
#    close($OUT_FILE);
    my $retcode = qx(/usr/bin/tftp -g -r $remote_file -l $local_file $remote_server ; echo $?);
    chmod(0600, $local_file);
    if ($retcode == 0)
    {
        $result = $url;
    }
    else
    {
        unlink $local_file;
        $result = ''
    }
    return $result;
}

#===============================================================================
# url_*_put functions.
#===============================================================================
sub url_put
{
    my $self       = shift;
    my $url        = shift;
    my $local_file = shift;

    # Parse the URL.
    my ($remote_protocol, undef, undef, $remote_server, $remote_file, undef, undef) = $self->url_parse($url);

    my $result = '';
    given ($remote_protocol)
    {
        when (/^confrw$/) { $result = $self->url_confrw_put($local_file, $remote_file, $remote_server); }
        when (/^file$/  ) { $result = $self->url_file_put(  $local_file, $remote_file, $remote_server); }
        when (/^http$/  ) { $result = $self->url_http_put(  $local_file, $remote_file, $remote_server); }
        when (/^tftp$/  ) { $result = $self->url_tftp_put(  $local_file, $remote_file, $remote_server); }
        default           { $self->message_log('err', qq(error: MiniMyth::url_put: protocol ') . $_ . qq(' is not supported.)); }
    }
    return $result;
}

sub url_confrw_put
{
    my $self        = shift;
    my $local_file  = shift;
    my $remote_file = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $hostname = Sys::Hostname::hostname();
    my $remote_file_0 = undef;

    if ($hostname)
    {
        $remote_file_0 = $remote_file;
        $remote_file_0 =~ s/\//+/;
        $remote_file_0 = 'conf-rw/' . $hostname . '+' . $remote_file_0;
    }

    my $result = '';
    if (! -f $local_file)
    {
        $self->message_log('err', qq(MiniMyth::url_confrw_put: local file ') . $local_file . qq(' not found.));
        return $result;
    }
    if ( $hostname eq '')
    {
        $self->message_log('err', qq(MiniMyth::url_confrw_put: hostname unknown.'));
        return $result;
    }
    if (($result eq '') && (defined $remote_file_0))
    {
        my $url = $self->var_get('MM_MINIMYTH_BOOT_URL') . $remote_file_0;
        $result = $self->url_put($url, $local_file);
    }
    return $result;
}

sub url_file_put
{
    my $self        = shift;
    my $local_file  = shift;
    my $remote_file = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;

    my $remote_dir = undef;

    $remote_dir = $remote_file;
    $remote_dir =~ s/[^\/]*$//;
    $remote_dir =~ s/\$//;

    my $result = '';

    File::Path::mkpath($remote_dir, {mode => 0755});
    (-d $remote_dir) or return $result;

    unlink $remote_file;
    if (! -f $remote_file)
    {
        $self->message_log('err', qq(MiniMyth::url_file_put: local file ') . $local_file . qq(' not found.));
        return $result;
    }
    File::Copy::copy($local_file, $remote_file) and $result = 'file:' . $remote_file;
    if ($result eq '')
    {
        unlink $remote_file;
    }
    return $result;
}

sub url_http_put
{
    my $self          = shift;
    my $local_file    = shift;
    my $remote_file   = shift;
    my $remote_server = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $result = '';
    if (! -f $local_file)
    {
        $self->message_log('err', qq(MiniMyth::url_http_put: local file ') . $local_file . qq(' not found.));
        return $result;
    }
    my $url = 'http://' . $remote_server . '/'. $remote_file;
    my $local_file_size = -s $local_file;
    open(my $IN_FILE, '<', $local_file) || do { return $result; };
    open(my $OUT_FILE, '>', File::Spec->devnull) || do { close($IN_FILE); return $result; };
    my $curl = new WWW::Curl::Easy;
    $curl->setopt(CURLOPT_VERBOSE, 0);
    $curl->setopt(CURLOPT_URL, $url);
    $curl->setopt(CURLOPT_INFILE, $IN_FILE);
    $curl->setopt(CURLOPT_INFILESIZE, $local_file_size);
    $curl->setopt(CURLOPT_WRITEDATA, $OUT_FILE);
    $curl->setopt(CURLOPT_PUT, 1);
    my $retcode = $curl->perform;
    close($IN_FILE);
    close($OUT_FILE);
    if ($retcode == 0)
    {
        $result = $url;
    }
    else
    {
        $result = ''
    }
    return $result;
}

sub url_tftp_put
{
    my $self          = shift;
    my $local_file    = shift;
    my $remote_file   = shift;
    my $remote_server = shift;

    $local_file =~ s/\/+/\//g;
    $local_file =~ s/\/$//g;

    $remote_file =~ s/\/+/\//g;
    $remote_file =~ s/\/$//g;
    $remote_file =~ s/^\///g;

    my $result = '';
    if (! -f $local_file)
    {
        $self->message_log('err', qq(MiniMyth::url_tftp_put: local file ') . $local_file . qq(' not found.));
        return $result;
    }
    my $url = 'tftp://' . $remote_server . '/'. $remote_file;
#    my $local_file_size = -s $local_file;
#    open(my $IN_FILE, '<', $local_file) || do { return $result; };
#    open(my $OUT_FILE, '>', File::Spec->devnull) || do { close($IN_FILE); return $result; };
#    my $curl = new WWW::Curl::Easy;
#    $curl->setopt(CURLOPT_VERBOSE, 0);
#    $curl->setopt(CURLOPT_URL, $url);
#    $curl->setopt(CURLOPT_INFILE, $IN_FILE);
#    $curl->setopt(CURLOPT_INFILESIZE, $local_file_size);
#    $curl->setopt(CURLOPT_WRITEDATA, $OUT_FILE);
#    my $retcode = $curl->perform;
#    close($IN_FILE);
#    close($OUT_FILE);
    my $retcode = qx(/usr/bin/tftp -p -l $local_file -r $remote_file $remote_server ; echo $?);
    if ($retcode == 0)
    {
        $result = $url;
    }
    else
    {
        $result = ''
    }
    return $result;
}

#===============================================================================
# confro_* and mm_confrw_* functions.
#===============================================================================
sub confro_get
{
    my $self        = shift;
    my $remote_file = shift;
    my $local_file  = shift;

    my $result = $self->url_confro_get($local_file, $remote_file);

    return $result;
}

sub confrw_get
{
    my $self        = shift;
    my $remote_file = shift;
    my $local_file  = shift;

    my $result = $self->url_confrw_get($local_file, $remote_file);

    return $result;
}

sub confrw_put
{
    my $self        = shift;
    my $remote_file = shift;
    my $local_file  = shift;

    my $result = $self->url_confrw_put($local_file, $remote_file);

    return $result;
}

#-------------------------------------------------------------------------------
# url_mount
#
# This function mounts a remote directory as a local directory.
#
# This function takes three arguments:
#     URL: required argument:
#         A URL that points to the remote directory. A URL must have the
#         following form:
#             <protocol>://<username>:<password>@<server>/<path>?<options>
#         where <options> are additional mount options (-o).
#         For example:
#             nfs://server.home/home/public/music
#             cifs://user:pass@server.home/home/public/music,domain=home
#             confrw:themecaches/G.A.N.T..1024.768.sfs<br/>
#         The valid protocol values are: 'nfs', 'cifs', 'http', 'tftp',
#         'confro', 'confrw', 'dist', 'hunt' and 'file'. For 'nfs' and 'cifs'
#         the URL points to a remote directory. For 'http', 'tftp', 'confro',
#         'confrw', 'dist' and 'hunt', the URL points to a remote file. For
#         'file', the URL point to a local directory or file. A directory will
#         be mounted at the mount point. A file, which can be a squashfs image
#         (*.sfs.), cramfs image (*.cmg) or a tarball file (*.tar.bz2) will be
#         downloaded and mounted at (for *.sfs and *.cmg files) or downloaded
#         and expanded into (for *.tar.bz2 files) the mount point. The 'confro',
#         'confrw', 'dist' and 'hunt' are special MiniMyth specific URLs. A
#         'dist' URL causes MiniMyth to look for the file in the MiniMyth
#         distribution directory (the directory with the MiniMyth root file
#         system squashfs image). A 'confro' URL causes MiniMyth to look for the
#         file in the MiniMyth read-only configuration directory. A 'confrw' URL
#         causes MiniMyth to look for the file in the MiniMyth read-write
#         configuration directory. A 'hunt' URL causes MiniMyth to look for the
#         file first in the MiniMyth distribution directory and second in the
#         MiniMyth read-only configuration directory.
#     MOUNT_DIR: required argument:
#         The local directory (e.g. /mnt/music) where the URL will be mounted.
#-------------------------------------------------------------------------------
sub url_mount
{
    my $self      = shift;
    my $url       = shift;
    my $mount_dir = shift;

    if (! -e $mount_dir)
    {
        File::Path::mkpath($mount_dir) || return 0;
    }

    # Parse the URL.
    my ($url_protocol, $url_username, $url_password, $url_server, $url_path, $url_options, undef) = $self->url_parse($url);

    my $url_file = File::Basename::basename($url_path);
    my $url_ext  = $url_file;
    my @url_exts = split(/\./, $url_file); shift(@url_exts);
    my $url_ext1 = pop(@url_exts);
    my $url_ext2 = pop(@url_exts);

    my $mount_vfstype = '';
    my $extra_options = '';
    my $mount_device  = '';
    my $mount_options = $url_options;
    if    ($url_protocol eq 'nfs')
    {
        $mount_vfstype = 'nfs';
        $mount_device  = $url_server . ':' . $url_path;
        $mount_options = 'nolock,' . $mount_options;
    }
    elsif ($url_protocol eq 'cifs')
    {
        $mount_vfstype = 'cifs';
        $mount_device  = '//' . $url_server . $url_path;
        if ($url_password ne '')
        {
            $mount_options = 'password=' . $url_password . ',' . $mount_options;
        }
        if ($url_username ne '')
        {
            $mount_options = 'username=' . $url_username . ',' . $mount_options;
        }
    }
    elsif (( $url_protocol eq 'confro'                   ) ||
           ( $url_protocol eq 'confrw'                   ) ||
           ( $url_protocol eq 'dist'                     ) ||
           (($url_protocol eq 'file'  ) && (-f $url_path)) ||
           ( $url_protocol eq 'http'                     ) ||
           ( $url_protocol eq 'hunt'                     ) ||
           ( $url_protocol eq 'tftp'                     ))
    {
        if    ($url_ext1 eq 'sfs')
        {
            my $dir  = $mount_dir;
            $dir =~ s/\/+/~/g;
            $dir = "/initrd/rw/loopfs/$dir";
            my $file = 'image.sfs';
            File::Path::mkpath("$dir");
            File::Path::mkpath("$dir/ro");
            File::Path::mkpath("$dir/rw");
            $self->url_get($url, "$dir/$file") || return 0;
            system(qq(/bin/mount -t squashfs -o loop "$dir/$file" "$dir/ro")) && return 0;
            system(qq(/bin/mount -t unionfs -o dirs=$dir/rw=rw:$dir/ro=ro none "$mount_dir")) && return 0;
        }
        elsif ($url_ext1 eq 'cmg')
        {
            my $dir  = $mount_dir;
            $dir =~ s/\/+/~/g;
            $dir = "/initrd/rw/loopfs/$dir";
            my $file = 'image.cmg';
            File::Path::mkpath("$dir");
            File::Path::mkpath("$dir/ro");
            File::Path::mkpath("$dir/rw");
            $self->url_get($url, "$dir/$file") || return 0;
            system(qq(/bin/mount -t cramfs -o loop "$dir/$file" "$dir/ro")) && return 0;
            system(qq(/bin/mount -t unionfs -o dirs=$dir/rw=rw:$dir/ro=ro none "$mount_dir")) && return 0;
        }
        elsif (($url_ext1 eq 'bz2') && ($url_ext2 eq 'tar'))
        {
            my $dir  = $mount_dir;
            my $file = "tmp.tar.bz2~";
            $self->url_get($url, "$dir/$file") || return 0;
            system(qq(/bin/tar -C "$dir" -jxf "$dir/$file")) && return 0;
            unlink("$dir/$file") || return 0;
        }
    }
    elsif (($url_protocol eq 'file'  ) && (-d $url_path))
    {
        system(qq(/bin/mount --rbind "$url_path" "$mount_dir")) && return 0;
    }
    else
    {
        $self->message_log('err', qq(MiniMyth::url_mount: protocol ') . $url_protocol . qq(' is not supported.));
        return 0;
    }

    if ($mount_vfstype)
    {
        my $options = '';
        $mount_options =~ s/^,//;
        $mount_options =~ s/,$//;
        $mount_options =~ s/^ +//;
        $mount_options =~ s/ +$//;
        ($extra_options) && ($options = $extra_options);
        ($mount_options) && ($options = $options . ' -o ' . $mount_options);
        $options =~ s/^ +//;
        $options =~ s/ +$//;
        system(qq(/bin/mount -n -t "$mount_vfstype" $options "$mount_device" "$mount_dir")) && return 0;
    }

    return 1;
}

sub file_replace_variable
{
    my $self  = shift;
    my $file  = shift;
    my $vars  = shift;

    my $mode = (stat($file))[2];
    if ((! -e "$file.$$") && (open(OFILE, '>', "$file.$$")))
    {
        chmod($mode, "$file.$$");
        if ((-r "$file") && (open(IFILE, '<', "$file")))
        {
            while (<IFILE>)
            {
                my $line = $_;
                foreach (keys %{$vars})
                {
                    my $name  = $_;
                    my $value = $vars->{$_};
                    $line =~ s/$name/$value/g;
                }
                print OFILE $line;
            }
            close(IFILE);
        }
        close(OFILE);
    }
    unlink("$file");
    rename("$file.$$", "$file");
}

#===============================================================================
# Restore and Save functions.
#===============================================================================
sub game_restore
{
    my $self = shift;

    my $file        = 'game.tar';
    my $remote_file = $file;
    my $local_dir   = $ENV{'HOME'} . '/' . 'tmp';
    my $local_file  = $local_dir . '/' . $file;

    File::Path::mkpath($local_dir);
    if (! -d $local_dir)
    {
        return 0;
    }

    unlink($local_file);

    $self->confrw_get($remote_file, $local_file);

    if (! -e $local_file)
    {
        return 0;
    }

    system(qq(/bin/tar -C /home/minimyth -xf $local_file));

    unlink($local_file);

    return 1;
}

sub game_save
{
    my $self = shift;

    my $file        = 'game.tar';
    my $remote_file = $file;
    my $local_dir   = $ENV{'HOME'} . '/' . 'tmp';
    my $local_file  = $local_dir . '/' . $file;

    File::Path::mkpath($local_dir);
    if (! -d $local_dir)
    {
        return 0;
    }

    # Enumerate all the files to be saved.
    my @game_save_list =();
    my @game_save_full = split(':', $self->var_get('MM_GAME_SAVE_LIST'));
    foreach (@game_save_full)
    {
        if (-e '/home/minimyth/' . $_)
        {
            push(@game_save_list, $_);
        }
    }
    my $game_save_list = join(' ', @game_save_list);

    if ($game_save_list)
    {
        File::Path::mkpath('/home/minimyth');
        unlink ($local_file);
        if (system(qq(/bin/tar -C '/home/minimyth' -cf $local_file $game_save_list)) != 0)
        {
            unlink ($local_file);
        }

        if (! -e $local_file)
        {
            $self->message_log('error', "failed to create game files tarball.");
            return 0;
        }

        if ($self->confrw_put($remote_file, $local_file) != 0)
        {
            unlink ($local_file);
            return 0;
        }

        unlink ($local_file);
    }

    return 1;
}

sub codecs_fetch_and_save
{
    my $self = shift;

    my $devnull = File::Spec->devnull;

    my $file        = 'codecs.sfs';
    my $remote_file = $file;
    my $local_dir   = $ENV{'HOME'} . '/' . 'tmp';
    my $local_file  = $local_dir . '/' . $file;

    File::Path::mkpath($local_dir);
    if (! -d $local_dir)
    {
        return 0;
    }

    my $codecs_base = qq(essential-20061022);
    my $codecs_file = qq($codecs_base.tar.bz2);
    my $codecs_url  = qq(http://www.mplayerhq.hu/MPlayer/releases/codecs/$codecs_file);
    File::Path::rmtree(qq($local_dir/$codecs_base));
    unlink(qq($local_dir/$codecs_file));
    if (! $self->url_get($codecs_url, qq($local_dir/$codecs_file)))
    {
        $self->message_log('error', qq(failed to create the codecs file because no codecs were downloaded.));
        File::Path::rmtree(qq($local_dir/$codecs_base));
        unlink(qq($local_dir/$codecs_file));
        return 0;
    }
    system(qq(/bin/tar -C $local_dir -jxf $local_dir/$codecs_file));
    unlink(qq($local_dir/$codecs_file));

    if (! -d $local_dir/$codecs_base)
    {
        my $file_found = 0;
        if (opendir(DIR, $local_dir/$codecs_base))
        {
            foreach (grep(! /^\./, (readdir(DIR))))
            {
                $file_found = 1;
                last;
            }
            closedir(DIR);
        }
        if (! $file_found)
        {
            $self->message_log('error', qq(failed to create the codecs file because downloaded codecs file was empty.));
            File::Path::rmtree(qq($local_dir/$codecs_base));
            return 0;
        }
    }

    my $uid = getpwnam('minimyth');
    my $gid = getgrnam('minimyth');
    File::Find::finddepth(
        sub
        {
            chown($uid, $gid, $File::Find::name);
            if (-d $File::Find::name)
            {
                chmod(0755, $File::Find::name);
            }
            else
            {
                chmod(0644, $File::Find::name);
            }
        },
        "$local_dir/$codecs_base");

    unlink(qq($local_file));
    if (system(qq(/usr/bin/fakeroot /usr/bin/mksquashfs "$local_dir/$codecs_base" "$local_file" > "$devnull" 2>&1)) != 0)
    {
        File::Path::rmtree(qq($local_dir/$codecs_base));
        unlink(qq($local_file));
        $self->message_log('error', qq(failed to create the codecs file because squashfs failed.));
        return 0;
    }

    if (! $self->confrw_put($remote_file, $local_file))
    {
        unlink(qq($local_file));
        $self->message_log('error', qq(failed to save the codecs file.));
        return 0;
    }

    unlink(qq($local_file));

    return 1;
}

sub extras_save
{
    my $self = shift;

    my $devnull = File::Spec->devnull;

    if (! -d '/usr/local')
    {
        $self->message_log('error', qq(failed to create the extras file because the extras directory does not exist.));
        return 0;
    }
    my $file_found = 0;
    if (opendir(DIR, '/usr/local'))
    {
        foreach (grep(! /^\./, (readdir(DIR))))
        {
            $file_found = 1;
            last;
        }
        closedir(DIR);
    }
    if (! $file_found)
    {
        $self->message_log('error', qq(failed to create the extras file because the extras directory is empty.));
        return 0;
    }

    my $file        = 'extras.sfs';
    my $remote_file = $file;
    my $local_dir   = $ENV{'HOME'} . '/' . 'tmp';
    my $local_file  = $local_dir . '/' . $file;

    unlink($local_file);
    File::Path::mkpath($local_dir, { mode => 700 });
    if (! -d $local_dir)
    {
        return 0;
    }

    if (system(qq(/usr/bin/fakeroot /usr/bin/mksquashfs '/usr/local' "$local_file" > "$devnull" 2>&1)) != 0)
    {
        unlink($local_file);
        $self->message_log('error', qq(failed to create the extras file because squashfs failed.));
        return 0;
    }

    if (! $self->confrw_put($remote_file, $local_file))
    {
        unlink($local_file);
        $self->message_log('error', qq(failed to save the extras file.));
        return 0;
    }

    unlink($local_file);

    return 1;
}

sub themecache_save
{
    my $self = shift;

    my $devnull = File::Spec->devnull;

    if (! -d '/home/minimyth/.mythtv/themecache')
    {
        $self->message_log('error', qq(failed to create the MythTV themecache file because the MythTV themecache directory does not exist.));
        return 0;
    }
    my $file = '';
    my $file_found = 0;
    if (opendir(DIR, '/home/minimyth/.mythtv/themecache'))
    {
        foreach (grep(! /^\./, (readdir(DIR))))
        {
            $file = "$_.sfs";
            $file_found++;
        }
        closedir(DIR);
    }
    if ($file_found ne 1)
    {
        $self->message_log('error', qq(failed to create the MythTV themecache file because the MythTV themecache directory does not contain exactly one cached theme.));
        return 0;
    }

    my $remote_file = 'themecaches' . '/' . $file;
    my $local_dir   = $ENV{'HOME'} . '/' . 'tmp';
    my $local_file  = $local_dir . '/' . $file;

    unlink($local_file);
    File::Path::mkpath($local_dir, { mode => 700 });
    if (! -d $local_dir)
    {
        return 0;
    }

    if (system(qq(/usr/bin/fakeroot /usr/bin/mksquashfs '/home/minimyth/.mythtv/themecache' "$local_file" > "$devnull" 2>&1)) != 0)
    {
        unlink($local_file);
        $self->message_log('error', qq(failed to create the MythTV themecache file because squashfs failed.));
        return 0;
    }

    if (! $self->confrw_put($remote_file, $local_file))
    {
        unlink($local_file);
        $self->message_log('error', qq(failed to save the MythTV themecache file.));
        return 0;
    }

    unlink($local_file);

    return 1;
}

#===============================================================================
# X functions.
#===============================================================================
sub x_xmacroplay
{
    my $self    = shift;
    my $program = shift;
    my $command = shift;

    my $devnull = File::Spec->devnull;

    # Make sure that the program is running.
    if (qx(/bin/pidof $program))
    {
        # Make sure that the X window manager is running, since we depend on it to select the program window.
        if (qx(/bin/pidof ratpoison))
        {
            # Set ratpoison to select window by program name.
            system(qq(/usr/bin/ratpoison -d :0.0 -c "set winname class"));
            # Select the program window.
            system(qq(/usr/bin/ratpoison -d :0.0 -c "select $program"));
            # Make sure the program window is selected.
            my $window = '';
            if (open(FILE, '-|', qq(/usr/bin/ratpoison -d :0.0 -c 'info' 2> $devnull)))
            {
                while (<FILE>)
                {
                    chomp;
                    if (/^.*\(([^()]*)\)$/)
                    {
                        $window = $1;
                        last;
                    }
                }
                close(FILE);
            }
            if ($window eq $program)
            {
                # Send key sequence to window.
                if (open(FILE, '|-', "/usr/bin/xmacroplay -d 100 :0.0 > $devnull 2>&1"))
                {
                    print FILE $command . "\n";
                    close(FILE);
                }
            }
        }
        else
        {
            $self->message_output('error', "cannot command '$program' without X window manager enabled.");
        }
    }

    return 1;
}

# Expand the applications list.
#
# The applications list contains names of applications or names of application
# groups. Application groups are identified by preceeding them with a ':'. The
# following groups:
#   :everything
#   :browser
#   :game
#   :player
#   :terminal
sub x_applications_list
{
    my $self         = shift;
    my $applications = shift;

    # Convert application groups to application names.
    if ($applications->{':everything'})
    {
        $applications->{':browser'} = 1;
        $applications->{':game'} = 1;
        $applications->{':player'} = 1;
        $applications->{':terminal'} = 1;
        delete $applications->{':everything'};
    }
    if ($applications->{':browser'})
    {
        $applications->{'mythbrowswer'} = 1;
        delete $applications->{':browser'};
    }
    if ($applications->{':game'})
    {
        $applications->{'fceu'} = 1;
        $applications->{'jzintv'} = 1;
        $applications->{'mame'} = 1;
        $applications->{'mess'} = 1;
        $applications->{'mednafen'} = 1;
        $applications->{'stella'} = 1;
        $applications->{'VisualBoyAdvance'} = 1;
        $applications->{'zsnes'} = 1;
        delete $applications->{':game'};
    }
    if ($applications->{':player'})
    {
        $applications->{'mplayer'} = 1;
        $applications->{'mplayer-svn'} = 1;
        $applications->{'mythtv'} = 1;
        $applications->{'vlc'} = 1;
        $applications->{'xine'} = 1;
        delete $applications->{':player'};
    }
    if ($applications->{':terminal'})
    {
        $applications->{'rxvt'} = 1;
        delete $applications->{':terminal'};
    }

    return $applications;
}

# Exit all applications in the list, assuming that we know how.
sub x_applications_exit
{
    my $self         = shift;
    my $applications = $self->x_applications_list(shift);

    foreach my $application (keys %{$applications})
    {
        if (qx(/bin/pidof $application))
        {
            my $xmacro = '';
            given ($application)
            {
                # Myth
                when (/^mythfrontend$/)
                {
                    # If mythfrontend is running, then return it to the Main Menu using the Network Control interface.
                    if (qx(/bin/pidof mythfrontend))
                    {
                        for (my $timeout = 10 ; $timeout > 0 ; $timeout--)
                        {
                            if ($self->mythfrontend_networkcontrol('query location')->[0] eq 'MainMenu')
                            {
                                last;
                            }
                            $self->mythfrontend_networkcontrol('jump mainmenu');
                            sleep 1;
                        }
                    }
                }
                # Browsers
                when (/^mythbrowser$/)      { $xmacro = 'KeyStr Escape\n'; }
                # Players
                when (/^mplayer$/)          { $xmacro = 'KeyStr Escape\n'; }
                when (/^mplayer-svn$/)      { $xmacro = 'KeyStr Escape\n'; }
                when (/^mythtv$/)           { $xmacro = 'KeyStr Escape\n'; }
# Does not work because the window name is not 'vlc'.
#               when (/^vlc$/)
                {
                    $xmacro='KeyStrPress Control_L\n KeyStrPress Q\n KeyStrRelease Q\n KeyStrRelease Control_L\n';
                }
                when (/^xine$/)             { $xmacro = 'KeyStr Q\n';      }
                # Games
                when (/^fceu$/)             { $xmacro = 'KeyStr Escape\n'; }
                when (/^jzintv$/)           { $xmacro = 'KeyStr F1\n';     }
                when (/^mame$/)             { $xmacro = 'KeyStr Escape\n'; }
                when (/^mess$/)             { $xmacro = 'KeyStr Escape\n'; }
                when (/^mednafen$/)         { $xmacro = 'KeyStr Escape\n'; }
                when (/^stella$/)
                {
                    $xmacro = 'KeyStrPress Control_L\n KeyStrPress Q\n KeyStrRelease Q\n KeyStrRelease Control_L\n';
                }
                when (/^VisualBoyAdvance$/) { $xmacro = 'KeyStr Escape\n'; }
                when (/^zsnes$/)            { $xmacro = 'KeyStr Escape\n KeyStr Q\n KeyStr Return\n'; }
                # Terminals
# Does not work because rxvt does not have a key sequence to quit.  Also, the window is named 'xterm' not 'rxvt'.
#               when (/^rxvt$/)             { $xmacro = '';                }
            }
            if ($xmacro)
            {
                $self->x_xmacroplay($application, $xmacro);
                if (qx(/bin/pidof $application))
                {
                    $self->message_output('error', "failed to exit '$application'.");
                }
            }
        }
    }

    return 1;
}

# Kill all applications in the list.
sub x_applications_kill
{
    my $self         = shift;
    my $applications = $self->x_applications_list(shift);

    foreach my $application (keys %{$applications})
    {
        my @pids = split(/ +/, qx(/bin/pidof $application));
        foreach (@pids)
        {
            my $devnull = File::Spec->devnull;
            system(qq(/bin/kill -SIGTERM $_ > $devnull 2>&1));
        }
    }

    return 1;
}

# Wait until all applications in the list are dead.
sub x_applications_dead
{
    my $self         = shift;
    my $applications = $self->x_applications_list(shift);

    my $dead = 0;
    while ($dead == 0)
    {
        $dead = 1;
        foreach (keys %{$applications})
        {
            if (qx(/bin/pidof $_))
            {
                my $dead = 0;
                sleep 1;
            }
        }
    }

    return 1;
}

# Start X.
sub x_start
{
    my $self = shift;

    my $devnull = File::Spec->devnull;

    $self->message_log('info', "starting X");

    # Only root start X.
    my $user = getpwuid(qx(/usr/bin/id -u));
    if ($user ne 'root')
    {
        $self->message_log('info', "X not started because uid=$user is not 'root'.");
        return 0;
    }

    # Only start X if X is enabled.
    if ($self->var_get('MM_X_ENABLED') ne 'yes')
    {
        $self->message_log('info', "X not started because X not enabled in minimyth.conf.");
        return 0;
    }

    # Only start X if X is not already running.
    if (qx(/bin/pidof X))
    {
        $self->message_log('info', "X not started because X is already running.");
        return 0;
    }

    system(qq(/bin/su -c '/usr/bin/nohup /usr/bin/xinit > $devnull 2>&1 &' - minimyth));

    if (qx(/bin/pidof mm_sleep_on_ss))
    {
        system(qq(/usr/bin/killall mm_sleep_on_ss));
    }
    if ($self->var_get('MM_X_SCREENSAVER_HACK') eq 'sleep')
    {
        system(qq(/usr/bin/mm_sleep_on_ss &));
    }

    return 1;
}

# Stop X.
sub x_stop
{
    my $self = shift;

    my $devnull = File::Spec->devnull;

    $self->message_log('info', "stopping X");

    my $log_file = File::Spec->devnull;

    # Only users root and minimyth can stop X.
    my $user = getpwuid(qx(/usr/bin/id -u));
    if ($user ne 'root')
    {
        $self->message_log('info', "X not stopped because uid=$user is not 'root'.");
        return 0;
    }

    if (qx(/bin/pidof mm_sleep_on_ss))
    {
        system(qq(/usr/bin/killall mm_sleep_on_ss));
    }

    # Only stop X if X is running.
    if (! qx(/bin/pidof X))
    {
        $self->message_log('info', "X not stopped because X is not running.");
        return 0;
    }

    # Exit X applications that are known not to be started by xinit
    $self->x_applications_exit({ ':everything' => 1 });
    $self->x_applications_kill({ ':everything' => 1 });
    $self->x_applications_dead({ ':everything' => 1 });

    # Return mythfrontend to the main menu
    $self->x_applications_exit({ 'mythfrontend' => 1 });

    # Create the list of X applications that may have been started by xinit but are not keeping X alive,
    # then them and wait for them to die.
    {
        my %applications = ();
        # Create a list of all applications that xinit might start.
        $applications{$self->var_get('MM_X_MYTH_PROGRAM')} = 1;
        $applications{'mythfrontend'} = 1;
        $applications{'mythwelcome'} = 1;
        $applications{'ratpoison'} = 1;
        $applications{'X'} = 1;
        $applications{'x11vnc'} = 1;
        $applications{'xinit'} = 1;
        $applications{'xscreensaver'} = 1;
        # Remove applications that might be keeping X alive.
        delete $applications{'xinit'};
        delete $applications{'X'};
        delete $applications{$self->var_get('MM_X_MYTH_PROGRAM')};
        # Kill them and wait for them to die.
        $self->x_applications_kill(\%applications);
        $self->x_applications_dead(\%applications);
    }

    # Create the list of xlsclients X applications but are not keeping X alive,
    # then kill them and wait for them to die.
    #   All of these should have been killed when we killed the list of known X applications not keeping X alive.
    #   However, there may be some unknown X applications not keeping X alive that we need to kill.
    if (open(FILE, '-|', "/usr/bin/xlsclients -display ':0.0' -a 2> $devnull"))
    {
        # Create a list of xlsclients X applications.
        my %applications = ();
        while (<FILE>)
        {
            chomp;
            s/^([^ ]+) +([^ ]+)( .*)?$/$2/;
            s/^.*\///;
            $applications{$_} = 1;
        }
        # Remove applications that might be keeping X alive.
        delete $applications{'xinit'};
        delete $applications{'X'};
        delete $applications{$self->var_get('MM_X_MYTH_PROGRAM')};
        # Kill them and wait for them to die.
        $self->x_applications_kill(\%applications);
        $self->x_applications_dead(\%applications);
    }

    # Create the list of the known X applications keeping X alive, kill them and wait for them to die.
    {
        my %applications = ();
        $applications{$self->var_get('MM_X_MYTH_PROGRAM')} = 1;
        $self->x_applications_kill(\%applications);
        $self->x_applications_dead(\%applications);
    }

    # Create the list of remaining known X applications and wait for them to die.
    {
        my %applications = ();
        $applications{'xinit'} = 1;
        $applications{'X'} = 1;
        $self->x_applications_dead(\%applications);
    }

    return 1;
}

1;
