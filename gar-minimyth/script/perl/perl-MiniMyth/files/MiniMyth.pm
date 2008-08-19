package MiniMyth;

use strict;
use warnings;
use feature "switch";

require DBD::mysql;
require DBI;
require File::Basename;
require File::Copy;
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
    system($command) && ($return = 0);
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
        system('/usr/bin/logger',       '-t', 'minimyth', '-p', 'local0.' . qq($level), $message);
        $self->splash_message_output($message);
    }
    else
    {
        system('/usr/bin/logger', '-s', '-t', 'minimyth', '-p', 'local0.' . qq($level), $message);
    }

    if (($level eq 'err') || ($level eq 'warn'))
    {
        my $log_file = '/var/log/minimyth.' .  $level . '.log';
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

    system('/usr/bin/logger', '-t', 'minimyth', '-p', 'local0.' . qq($level), $message);
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

    my $conf_file   = ($args && $args->{'file'}  ) || '/etc/conf';
    my $conf_filter = ($args && $args->{'filter'}) || 'MM_.*';

    my %conf_variable;

    if ((-x '/bin/sh') && (-r '/etc/rc.d/functions') && (-r $conf_file) && 
        (open(FILE, '-|', "/bin/sh -c '. /etc/rc.d/functions ; . $conf_file ; set'")))
    {
        foreach (grep(/^$conf_filter$/, (<FILE>)))
        {
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
        chmod(0644, '$conf_file.$$');
        foreach (sort keys %{$self->{'conf_variable'}})
        {
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
    if ((system("/bin/pidof $var_splash_command $devnull 2>&1") == 0) && (-e $var_splash_fifo))
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
    my $type = shift;

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
                ($LOGLEVEL) = split(/ /,$_);
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
        system('/usr/bin/chvt', '1');
        File::Path::mkpath($var_splash_fifo_dir,{mode => 0755});
        $self->splash_command('exit');
        system($var_splash_command, qq(--theme="minimyth"), qq(--progress="0"), qq(--mesg="$message"), qq(--type="$type"));
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

    my $hostname = Sys::Hostname::hostname();

    my $query = qq(DELETE FROM $table WHERE hostname="$hostname");
    foreach (keys %{$condition})
    {
        $query = $query . qq( AND $_="$condition->{$_}");
    }
    $self->mythdb_handle->do($query);
}

sub mythdb_x_get
{
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $field     = shift;

    my $hostname = Sys::Hostname::hostname();

    my $query = qq(SELECT * FROM $table WHERE hostname="$hostname");
    foreach (keys %{$condition})
    {
        $query = $query . qq( AND $_="$condition->{$_}");
    }

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

    my $hostname = Sys::Hostname::hostname();

    my $query = qq(SELECT * FROM $table WHERE hostname="$hostname");
    foreach (keys %{$condition})
    {
        $query = $query . qq( AND $_="$condition->{$_}");
    }

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

sub mythdb_x_set {
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $field     = shift;
    my $value     = shift;

    my $hostname = Sys::Hostname::hostname();

    my $query_delete = qq(DELETE FROM $table WHERE hostname="$hostname");
    my $query_insert = qq(INSERT INTO $table SET $field="$value" , hostname="$hostname");
    foreach (keys %{$condition})
    {
        $query_delete = $query_delete . qq( AND $_="$condition->{$_}");
        $query_insert = $query_insert . qq( , $_="$condition->{$_}");
    }
    $self->mythdb_handle->do($query_delete);
    $self->mythdb_handle->do($query_insert);
}

sub mythdb_x_update
{
    my $self      = shift;
    my $table     = shift;
    my $condition = shift;
    my $field     = shift;
    my $value     = shift;

    my $hostname = Sys::Hostname::hostname();

    my $query = qq(INSERT INTO $table SET $field="$value" WHERE hostname="$hostname");
    foreach (keys %{$condition})
    {
        $query = $query . qq( AND $_="$condition->{$_}");
    }
    $self->mythdb_handle->do($query);
}

sub mythdb_settings_delete
{
    my $self  = shift;
    my $value = shift;

    if ( $value ) { $self->mythdb_x_update('settings', { 'value' => $value }); }
    else          { $self->mythdb_x_update('settings', {});                    }
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
        return @lines;
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
    my    ($protocol, undef, undef, $username, undef, $password, $server, $path, undef, $query, undef, $fragment)
        = ($1       , $2   , $3   , $4       , $5   , $6       , $7     , $8   , $9   , $10   , $11  , $12)
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
    if ($result == '')
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
    if ($result == '')
    {
        $result = $self->url_dist_get($local_file, $remote_file);
    }
    if ($result == '')
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
    if ($result == '')
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
            my $file = 'image.sfs';
            File::Path::mkpath("$dir");
            File::Path::mkpath("$dir/ro");
            File::Path::mkpath("$dir/rw");
            $self->url_get($url, "$dir/$file") || return 0;
            system('/bin/mount', '-t', 'squashfs', '-o', 'loop', "$dir/$file", "$dir/ro") || return 0;
            system('/bin/mount', '-t', 'unionfs' ,'-o', "dirs=$dir/rw=rw:$dir/ro=ro", 'none', $mount_dir) || return 0;
        }
        elsif ($url_ext1 eq 'cmg')
        {
            my $dir  = $mount_dir; $dir =~ s/\/+/~/g;
            my $file = 'image.sfs';
            File::Path::mkpath("$dir");
            File::Path::mkpath("$dir/ro");
            File::Path::mkpath("$dir/rw");
            $self->url_get($url, "$dir/$file") || return 0;
            system('/bin/mount', '-t', 'cramfs' ,'-o', 'loop', "$dir/$file", "$dir/ro") || return 0;
            system('/bin/mount', '-t', 'unionfs', '-o', "dirs=$dir/rw=rw:$dir/ro=ro", 'none', $mount_dir) || return 0;
        }
        elsif (($url_ext1 eq 'bz2') && ($url_ext2 eq 'tar'))
        {
            my $dir  = $mount_dir;
            my $file = "tmp.tar.bz2~";
            $self->url_get($url, "$dir/$file") || return 0;
            system(qq(/bin/tar -C $dir -jxf "$dir/$file")) && return 0;
            unlink "$dir/$file" || return 0;
        }
    }
    elsif (($url_protocol eq 'file'  ) && (-d $url_path))
    {
        system('/bin/mount', '--rbind', $url_path, $mount_dir) || return 0;
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
        system('/bin/mount -n -t' . $mount_vfstype . $options . '"' . $mount_device . '" "' . $mount_dir . '"') || return 0;
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
                    $line =~ s/@$name@/$value/g;
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

1;
