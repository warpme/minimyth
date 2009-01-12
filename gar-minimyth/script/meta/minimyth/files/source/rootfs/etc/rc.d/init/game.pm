################################################################################
# game
################################################################################
package init::game;

use strict;
use warnings;

use MiniMyth ();

sub start
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_GAME_SAVE_ENABLED') eq 'yes')
    {
        $minimyth->message_output('info', "restoring selected game configuration files ...");
        $minimyth->game_restore();
    }

    return 1;
}

sub stop
{
    my $self     = shift;
    my $minimyth = shift;

    if ($minimyth->var_get('MM_GAME_SAVE_ENABLED') eq 'yes')
    {
        $minimyth->message_output('info', "saving selected game configuration files ...");
        $minimyth->game_save();
    }

    return 1;
}

1;
