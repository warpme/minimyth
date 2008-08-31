#!/usr/bin/perl

use warnings;
use strict;

require MiniMyth;

require "/srv/www/cgi-bin/mm_webpage.pm";

my $minimyth    = new MiniMyth;
my $server_name = $ENV{'SERVER_NAME'};

my @middle = ();

push(@middle,  q(<div class="section">));
push(@middle,  q(  <p>));
if ($minimyth->var_get('MM_SECURITY_ENABLED') eq 'no')
{
    push(@middle, qq(    You can use the URL <a href="http://$server_name:8080/">http://$server_name:8080/</a> to access your MiniMyth frontend's filesystem.));
}
else
{
    push(@middle,  q(    Your MiniMyth frontend has security enabled.));
    push(@middle,  q(    Therefore, you cannot access your MiniMyth frontend's filesystem.));
}
push(@middle,  q(  </p>));
push(@middle,  q(</div>));

my $page = mm_webpage->page($minimyth, { 'title' => 'Filesystem', 'middle' => \@middle });

print $_ . "\n" foreach (@{$page});

1;
