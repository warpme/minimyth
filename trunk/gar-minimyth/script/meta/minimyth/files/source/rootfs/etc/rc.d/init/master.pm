#!/usr/bin/perl
################################################################################
# master
################################################################################
package init::master;

use strict;
use warnings;

require MiniMyth;

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    $minimyth->message_output('info', "configuring MythTV master backend communication ...");
 
    # Determine hostname.
    my $hostname = $minimyth->hostname();

    # Determine broadcast address.
    my $master_wol_broadcast = undef;
    if (open(FILE, '-|', "/sbin/ifconfig " . $minimyth->var_get('MM_NETWORK_INTERFACE')))
    {
        foreach (grep(s/^.* Bcast:([^ ]*) .*$/$1/, (<FILE>)))
        {
            chomp;
            $master_wol_broadcast = $_;
            last;
        }
        close(FILE);
    }

    # Configure config.xml file.
    # The frontend runs as user 'minimyth' and the backend runs as user 'root'.
    # As a result, there is a config.xml file for both 'minimyth' and 'root'.
    $minimyth->file_replace_variable(
        '/home/minimyth/.mythtv/config.xml',
        { '@MM_HOSTNAME@'          => $hostname,
          '@MM_MASTER_SERVER@'     => $minimyth->var_get('MM_MASTER_SERVER'),
          '@MM_MASTER_DBUSERNAME@' => $minimyth->var_get('MM_MASTER_DBUSERNAME'),
          '@MM_MASTER_DBPASSWORD@' => $minimyth->var_get('MM_MASTER_DBPASSWORD'),
          '@MM_MASTER_DBNAME@'     => $minimyth->var_get('MM_MASTER_DBNAME') });
    $minimyth->file_replace_variable(
        '/root/.mythtv/config.xml',
        { '@MM_HOSTNAME@'          => $hostname,
          '@MM_MASTER_SERVER@'     => $minimyth->var_get('MM_MASTER_SERVER'),
          '@MM_MASTER_DBUSERNAME@' => $minimyth->var_get('MM_MASTER_DBUSERNAME'),
          '@MM_MASTER_DBPASSWORD@' => $minimyth->var_get('MM_MASTER_DBPASSWORD'),
          '@MM_MASTER_DBNAME@'     => $minimyth->var_get('MM_MASTER_DBNAME') });

    # Configure mysql.txt file.
    # The frontend runs as user 'minimyth' and the backend runs as user 'root'.
    # As a result, there is a mysql.txt file for both 'minimyth' and 'root'.
    my $wol_false;
    my $wol_true;
    if ($minimyth->var_get('MM_MASTER_WOL_ENABLED') eq 'yes')
    {
        $wol_false = '#';
        $wol_true  = '';
    }
    else
    {
        $wol_false = '';
        $wol_true  = '#';
    }
    # The WOL broadcast and MAC addresses are replaced separately because
    # the WOL SQL command includes the WOL broadcasst and MAC addresses as variables.
    $minimyth->file_replace_variable(
        '/home/minimyth/.mythtv/mysql.txt',
        { '@MM_HOSTNAME@'                       => $hostname,
          '@MM_MASTER_SERVER@'                  => $minimyth->var_get('MM_MASTER_SERVER'),
          '@MM_MASTER_DBUSERNAME@'              => $minimyth->var_get('MM_MASTER_DBUSERNAME'),
          '@MM_MASTER_DBPASSWORD@'              => $minimyth->var_get('MM_MASTER_DBPASSWORD'),
          '@MM_MASTER_DBNAME@'                  => $minimyth->var_get('MM_MASTER_DBNAME'),
          '@MM_MASTER_WOL_FALSE@'               => $wol_false,
          '@MM_MASTER_WOL_TRUE@'                => $wol_true,
          '@MM_MASTER_WOLSQLRECONNECTWAITTIME@' => $minimyth->var_get('MM_MASTER_WOLSQLRECONNECTWAITTIME'),
          '@MM_MASTER_WOLSQLCONNECTRETRY@'      => $minimyth->var_get('MM_MASTER_WOLSQLCONNECTRETRY'),
          '@MM_MASTER_WOLSQLCOMMAND@'           => $minimyth->var_get('MM_MASTER_WOLSQLCOMMAND') });
    $minimyth->file_replace_variable(
        '/home/minimyth/.mythtv/mysql.txt',
        { '@MM_MASTER_WOL_BROADCAST@'           => $master_wol_broadcast,
          '@MM_MASTER_WOL_MAC@'                 => $minimyth->var_get('MM_MASTER_WOL_MAC') });
    $minimyth->file_replace_variable(
        '/root/.mythtv/mysql.txt',
        { '@MM_HOSTNAME@'                       => $hostname,
          '@MM_MASTER_SERVER@'                  => $minimyth->var_get('MM_MASTER_SERVER'),
          '@MM_MASTER_DBUSERNAME@'              => $minimyth->var_get('MM_MASTER_DBUSERNAME'),
          '@MM_MASTER_DBPASSWORD@'              => $minimyth->var_get('MM_MASTER_DBPASSWORD'),
          '@MM_MASTER_DBNAME@'                  => $minimyth->var_get('MM_MASTER_DBNAME'),
          '@MM_MASTER_WOL_FALSE@'               => $wol_false,
          '@MM_MASTER_WOL_TRUE@'                => $wol_true,
          '@MM_MASTER_WOLSQLRECONNECTWAITTIME@' => $minimyth->var_get('MM_MASTER_WOLSQLRECONNECTWAITTIME'),
          '@MM_MASTER_WOLSQLCONNECTRETRY@'      => $minimyth->var_get('MM_MASTER_WOLSQLCONNECTRETRY'),
          '@MM_MASTER_WOLSQLCOMMAND@'           => $minimyth->var_get('MM_MASTER_WOLSQLCOMMAND') });
    $minimyth->file_replace_variable(
        '/root/.mythtv/mysql.txt',
        { '@MM_MASTER_WOL_BROADCAST@'           => $master_wol_broadcast,
          '@MM_MASTER_WOL_MAC@'                 => $minimyth->var_get('MM_MASTER_WOL_MAC') });
 
    # If using wake-on-lan, then make sure that the MythTV master backend is awake.
    if (($minimyth->var_get('MM_MASTER_WOL_ENABLED') eq 'yes') && (! $minimyth->mythdb_x_test()))
    {
        my $WOLSqlConnectRetry      = undef;
        my $WOLSqlReconnectWaitTime = undef;
        my $WOLSqlCommand           = undef;
        if (open(FILE, '<', '/home/minimyth/.mythtv/mysql.txt'))
        {
            while (<FILE>)
            {
                chomp;
                if (/^WOLSqlConnectRetry=(.*)$/)
                {
                    $WOLSqlConnectRetry = $1;
                }
		if (/^WOLSqlReconnectWaitTime=(.*)$/)
                {
                    $WOLSqlReconnectWaitTime = $1;
                }
		if (/^WOLSqlCommand=(.*)$/)
                {
                    $WOLSqlCommand = $1;
                }
            }
            close(FILE);
        }
        for ( my $WOLSqlConnectAttempt = 1 ;
              ($WOLSqlConnectAttempt <= $WOLSqlConnectRetry) && (! $minimyth->mythdb_x_test()) ;
              $WOLSqlConnectAttempt++ )
        {
            $minimyth->message_output('info', "waking MythTV master backend database ($WOLSqlConnectAttempt of $WOLSqlConnectRetry attempts) ...");

            system(qq($WOLSqlCommand));
            sleep $WOLSqlReconnectWaitTime;
        }
        # Wait the additional delay after MySQL is awake.
        if ($minimyth->mythdb_x_test())
        {
            my $delay_max = $minimyth->var_get('MM_MASTER_WOL_ADDITIONAL_DELAY');
            for ( my $delay = 0 ; $delay <= $delay_max ; $delay ++ )
            {
                $minimyth->message_output('info', "waiting while MythTV master backend wakes ($delay of $delay_max seconds) ...");
                sleep 1;
            }
        }
    }

    # Test Myth database connection.
    if (! $minimyth->mythdb_x_test())
    {
        $minimyth->message_output('err', "cannot connect to the MythTV master backend database.");
        return 0;
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    return 1;
}

1;
