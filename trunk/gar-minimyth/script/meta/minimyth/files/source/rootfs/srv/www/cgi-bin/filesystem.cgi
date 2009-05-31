#!/usr/bin/perl

use warnings;
use strict;

use MiniMyth ();

require "/srv/www/cgi-bin/mm_webpage.pm";

my $minimyth  = new MiniMyth;
my $http_host = $ENV{'HTTP_HOST'};

my @middle = ();

push(@middle,  q(<div class="section">));
push(@middle,  q(  <p>));
if ($minimyth->var_get('MM_SECURITY_ENABLED') eq 'no')
{
    push(@middle, qq(    You can use the URL <a href="ftp://$http_host">ftp://$http_host</a> to access your MiniMyth system's filesystem.));
}
else
{
    push(@middle,  q(    Your MiniMyth system has security enabled.));
    push(@middle,  q(    Therefore, you cannot access your MiniMyth system's filesystem.));
}
push(@middle,  q(  </p>));
push(@middle,  q(</div>));

my $page = mm_webpage->page($minimyth, { 'title' => 'Filesystem', 'middle' => \@middle });

print $_ . "\n" foreach (@{$page});

1;
