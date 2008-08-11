package MiniMyth;

use strict;

require Sys::Hostname;
require DBI;
require DBD::mysql;
require Net::Telnet;

sub new
{
    my $proto = shift;

    my $class = ref($proto) || $proto;

    my $self->{
        'conf_variable' => undef,
        'mythdb_handle' => undef
    };

    bless($self, $class);

    return $self;
}

sub _conf_init
{
    my $self = shift;

    if ( ! $self->{'conf_variable'} )
    {
        my %conf_variable;

        foreach (qx(sh -c '. /etc/conf ; set'))
        {
            /^(MM_[^=]+)='(.*)'$/ and $conf_variable{$1} = $2;
        }

        $self->{'conf_variable'} = \%conf_variable;
    }
}

sub conf
{
    my $self = shift;
    my $name = shift;

    $self->{'conf_variable'} || $self->_conf_init();

    my $value = $self->{'conf_variable'}->{$name};
    return $value;
}

sub _mythdb_init
{
    my $self = shift;

    if ( ! $self->{'mythdb_handle'} )
    {
        my $mythdb_handle;

        $self->{conf_variable} || $self->_conf_init();

        my $dbhostname = $self->{'conf_variable'}->{'MM_MASTER_SERVER'};
        my $dbdatabase = $self->{'conf_variable'}->{'MM_MASTER_DBNAME'};
        my $dbusername = $self->{'conf_variable'}->{'MM_MASTER_DBUSERNAME'};
        my $dbpassword = $self->{'conf_variable'}->{'MM_MASTER_DBPASSWORD'};

        my $dsn = "DBI:mysql:database=$dbdatabase;host=$dbhostname";

        $mythdb_handle = DBI->connect($dsn, $dbusername, $dbpassword);

        $self->{'mythdb_handle'} = $mythdb_handle;
    }
}

sub mythdb_settings_print
{
    my $self  = shift;
    my $value = shift;

    $self->{'mythdb_handle'} || $self->_mythdb_init();

    my $hostname = Sys::Hostname::hostname();

    my $mythdb_handle = $self->{'mythdb_handle'};

    my $sth;
    if ( $value )
    {
        $sth = $mythdb_handle->prepare(qq(SELECT * FROM settings WHERE hostname="$hostname" AND value="$value"));
    }
    else
    {
        $sth = $mythdb_handle->prepare(qq(SELECT * FROM settings WHERE hostname="$hostname"));
    }
    $sth->execute;
    print 'value' . "\t|\t" . 'data' . "\n";
    print '-----' . "\t|\t" . '----' . "\n";
    while (my $ref = $sth->fetchrow_hashref())
    {
        print $ref-{'value'} . "\t|\t" . $ref->${'data'} . "\n";
    }
    $sth->finish();
}

sub mythdb_settings_delete
{
    my $self  = shift;
    my $value = shift;

    $self->{'mythdb_handle'} || $self->_mythdb_init();

    my $hostname = Sys::Hostname::hostname();

    my $mythdb_handle = $self->{'mythdb_handle'};

    if ( $value )
    {
        $mythdb_handle->do(qq(DELETE FROM settings WHERE hostname="$hostname" AND value="$value"));
    }
    else
    {
        $mythdb_handle->do(qq(DELETE FROM settings WHERE hostname="$hostname"));
    }
}

sub mythdb_settings_update
{
    my $self  = shift;
    my $value = shift;
    my $data  = shift;

    $self->{'mythdb_handle'} || $self->_mythdb_init();

    my $hostname = Sys::Hostname::hostname();

    my $mythdb_handle = $self->{'mythdb_handle'};

    $mythdb_handle->do(qq(UPDATE settings SET data="$data" WHERE hostname="$hostname" value="$value"));
}

sub mythdb_settings_set
{
    my $self  = shift;
    my $value = shift;
    my $data  = shift;

    $self->{'mythdb_handle'} || $self->_mythdb_init();

    my $hostname = Sys::Hostname::hostname();

    my $mythdb_handle = $self->{'mythdb_handle'};

    $mythdb_handle->do(qq(DELETE FROM settings WHERE               hostname="$hostname" AND value="$value"));
    $mythdb_handle->do(qq(INSERT INTO settings SET   data="$data", hostname="$hostname",    value="$value"));
}

sub mythdb_settings_get
{
    my $self  = shift;
    my $value = shift;

    my $data;

    $self->{'mythdb_handle'} || $self->_mythdb_init();

    my $hostname = Sys::Hostname::hostname();

    my $mythdb_handle = $self->{'mythdb_handle'};
    my $sth = $mythdb_handle->prepare(qq(SELECT * FROM settings WHERE hostname="$hostname" AND value="$value"));
    $sth->execute;
    while (my $ref = $sth->fetchrow_hashref())
    {
        if (($ref->{'value'} eq $value) && ($ref->{'hostname'} eq $hostname))
        {
            $data = $ref->{'data'};
        }
    }
    $sth->finish();

    return $data;
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
