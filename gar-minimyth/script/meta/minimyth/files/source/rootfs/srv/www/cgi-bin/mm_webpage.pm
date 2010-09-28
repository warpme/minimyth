package mm_webpage;

use warnings;
use strict;

use Date::Manip ();
use MiniMyth ();

sub page
{
    my $self     = shift;
    my $minimyth = shift;
    my $args     = shift;

    my $style    = undef;
    my $title    = undef;
    my $middle   = undef;

    if (defined($args))
    {
        if (exists($args->{'style'}))
        {
            $style = $args->{'style'};
        }
        if (exists($args->{'title'}))
        {
            $title = $args->{'title'};
        }
        if (exists($args->{'middle'}))
        {
            $middle = $args->{'middle'};
        }
    }

    my $page_host  = $minimyth->hostname();
    my $page_date  = Date::Manip::UnixDate('now', '%Y-%m-%d %H:%M:%S %Z');
    my $mm_version = $minimyth->var_get('MM_VERSION');

    my @page = ();

    push(@page,  q(Content-Type: text/html; charset=utf-8));
    push(@page,  q());
    push(@page,  q(<!DOCTYPE HTML>));
    push(@page,  q(<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">));
    push(@page,  q(  <head>));
    push(@page,  q(    <meta http-equiv="content-type" content="text/html; charset=utf-8" />));
    push(@page,  q(    <meta name="author" content="Paul Bender" />));
    push(@page,  q(    <meta name="copyright" content="2006-2009 Paul Bender &#38; minimyth.org" />));
    push(@page,  q(    <meta name="keywords" content="PVR,Linux,MythTV,MiniMyth" />));
    push(@page,  q(    <meta name="description" content="" />));
    push(@page, qq(    <title>MiniMyth System $title</title>));
    push(@page,  q(    <style type="text/css" title="main-styles">));
    push(@page,  q(      @import "../css/minimyth.css";));
    if (defined($style))
    {
        foreach (@{$style})
        {
             push(@page,  q(      @import ) . qq("$_";));
        }
    }
    push(@page,  q(    </style>));
    push(@page,  q(  </head>));
    push(@page,  q(  <body>));
    push(@page,  q(    <div class="main">));
    push(@page,  q(      <div class="header">));
    push(@page,  q(        <div class="heading">MiniMyth from <a href="http://www.minimyth.org/">minimyth.org</a></div>));
    push(@page,  q(        <div class="menu">));
    push(@page,  q(          <span class="menuItemFirst"><a href="../index.html">Home</a></span>));
    push(@page, qq(          <span class="menuItem"     >$title</span>));
    push(@page,  q(        </div>));
    push(@page,  q(        <div class="note">));
    push(@page, qq(          $page_date<br />));
    push(@page, qq(          $page_host<br />));
    push(@page, qq(          $mm_version));
    push(@page,  q(        </div>));
    push(@page,  q(      </div>));
    push(@page,  q(      <div class="middle">));
    push(@page, qq(      <div class="heading">MiniMyth System $title</div>));
    push(@page, @{$middle});
    push(@page,  q(      </div>));
    push(@page,  q(      <div class="footer">));
    push(@page,  q(        <hr />));
    push(@page,  q(        <div class="valid-xhtml">));
    push(@page,  q(          <a href="http://validator.w3.org/check?uri=referer"><img));
    push(@page,  q(              style="border:0;width:88px;height:31px"));
    push(@page,  q(              title="Valid HTML 5"));
    push(@page,  q(              src="/image/validicons-blueHTML.gif"));
    push(@page,  q(              alt="Valid HTML 5" /></a>));
    push(@page,  q(        </div>));
    push(@page,  q(        <div class="valid-css">));
    push(@page,  q(          <a href="http://jigsaw.w3.org/css-validator/check/referer"><img));
    push(@page,  q(              style="border:0;width:88px;height:31px"));
    push(@page,  q(              title="Valid CSS 2.1"));
    push(@page,  q(              src="/image/validicons-blueCSS.gif"));
    push(@page,  q(              alt="Valid CSS 2.1" /></a>));
    push(@page,  q(        </div>));
    push(@page,  q(        <div class="version">));
    push(@page,  q(          Last Updated on 2010-09-19));
    push(@page,  q(          <br />));
    push(@page,  q(          &#60;&#160;mailto&#160;:&#160;webmaster&#160;at&#160;minimyth&#160;dot&#160;org&#160;&#62;));
    push(@page,  q(        </div>));
    push(@page,  q(      </div>));
    push(@page,  q(    </div>));
    push(@page,  q(  </body>));
    push(@page,  q(</html>));

    return \@page;
}

1;
