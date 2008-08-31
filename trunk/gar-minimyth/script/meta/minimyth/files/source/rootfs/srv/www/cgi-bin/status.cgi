#!/usr/bin/perl

use warnings;
use strict;

require File::Spec;
require MiniMyth;

require "/srv/www/cgi-bin/mm_webpage.pm";

my $minimyth   = new MiniMyth;
my $mm_version = $minimyth->var_get('MM_VERSION');
my $devnull    = File::Spec->devnull;

my $status_sensors_head = q(Sensors (output of command "sensors"));
my @status_sensors_body = ();
if (system(qq(/usr/bin/sensors > $devnull 2>&1)) == 0)
{
    if (open(FILE, '-|', '/usr/bin/sensors'))
    {
        while (<FILE>)
        {
            chomp;
            s/(\-[1-9][0-9]\.[0-9] C)/<span class="temp_cool">$1<\/span>/;
            s/(\-[1-9]\.[0-9] C)/<span class="temp_cool">$1<\/span>/;
            s/(\+[1-9]\.[0-9] C)/<span class="temp_cool">$1<\/span>/;
            s/(\+[1-4][0-9]\.[0-9] C)/<span class="temp_cool">$1<\/span>/;
            s/(\+[5-6][0-9]\.[0-9] C)/<span class="temp_warm">$1<\/span>/;
            s/(\+[7-9][0-9]\.[0-9] C)/<span class="temp_hot">$1<\/span>/;
            push(@status_sensors_body, $_);
        }
        close(FILE);
    }
}

my $status_loads_head = q(Loads (output of file "/proc/loadavg"));
my @status_loads_body = ();
if (-e 'proc/loadavg')
{
    if (open(FILE, '<', '/proc/loadavg'))
    {
        while (<FILE>)
        {
            chomp;
            push(@status_loads_body, $_);
        }
        close(FILE);
    }
}

my @middle = ();

push(@middle,  q(<div class="section">));
push(@middle, qq(  <div class="heading">$status_sensors_head</div>));
push(@middle,  q(  <div class="status">));
foreach (@status_sensors_body)
{
    push(@middle, qq($_));
}
push(@middle,  q(  </div>));
push(@middle,  q(</div>));
push(@middle,  q(<div class="section">));
push(@middle, qq(  <div class="heading">$status_loads_head</div>));
push(@middle,  q(  <div class="status">));
foreach (@status_loads_body)
{
    push(@middle, qq($_));
}
push(@middle,  q(  </div>));
push(@middle,  q(</div>));

my $page = mm_webpage->page($minimyth, { 'title' => 'Status', 'middle' => \@middle , 'style' => [ '../css/status.css' ] });

print $_ . "\n" foreach (@{$page});

1;
