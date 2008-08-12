package MiniMyth;

use strict;
use warnings;

require Sys::Hostname;
require DBI;
require DBD::mysql;
require Net::Telnet;

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

    if ( $self->{'conf_variable'} )
    {
        $self->{'mythdb_handle'}->disconnect;
    }
}

sub conf
{
    my $self = shift;
    my $name = shift;

    if ( ! $self->{'conf_variable'} )
    {
        my %conf_variable;

        foreach (qx(sh -c '. /etc/conf ; set'))
        {
            /^(MM_[^=]+)='(.*)'$/ and $conf_variable{$1} = $2;
        }

        $self->{'conf_variable'} = \%conf_variable;
    }

    return $self->{'conf_variable'}->{$name};
}

sub mythdb_handle
{
    my $self = shift;

    if ( ! $self->{'mythdb_handle'} )
    {
        my $mythdb_handle;

        my $dbhostname = $self->conf('MM_MASTER_SERVER');
        my $dbdatabase = $self->conf('MM_MASTER_DBNAME');
        my $dbusername = $self->conf('MM_MASTER_DBUSERNAME');
        my $dbpassword = $self->conf('MM_MASTER_DBPASSWORD');

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
        if ($field !~ m/hostname/)
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

1;
