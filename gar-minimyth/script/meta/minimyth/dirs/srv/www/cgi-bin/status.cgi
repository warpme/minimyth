#!/bin/sh

. /etc/conf

page_host=`/bin/hostname`
page_date=`/bin/date +'%Y-%m-%d %H:%M:%S %Z'`

server=${HTTP_HOST:-${SERVER_ADDR}}

status_sensors_head="Sensors (output of command \"sensors\")"
/usr/bin/sensors > /dev/null 2>&1
if /usr/bin/test $? -eq 0 ; then
    status_sensors_body=` \
        /usr/bin/sensors | \
        /bin/sed \
            -e 's/\(\-[1-9][0-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
            -e 's/\(\-[1-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
            -e 's/\(\+[1-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
            -e 's/\(\+[1-4][0-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
            -e 's/\(\+[5-6][0-9]\.[0-9] C\)/<span class="temp_warm">\1<\/span>/' \
            -e 's/\(\+[7-9][0-9]\.[0-9] C\)/<span class="temp_hot">\1<\/span>/'`
else
    status_sensors_body=
fi

status_loads_head="Loads (output of command \"cat /proc/loadavg\")"
status_loads_body=`/bin/cat /proc/loadavg`

/bin/echo "Content-Type: text/html; charset=UTF-8"
/bin/echo
/bin/echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">"
/bin/echo "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\">"
/bin/echo "  <head>"
/bin/echo "    <meta name=\"author\" content=\"Paul Bender\" />"
/bin/echo "    <meta name=\"copyright\" content=\"2006-2008 Paul Bender &amp; minimyth.org\" />"
/bin/echo "    <meta name=\"keywords\" content=\"PVR,Linux,MythTV,MiniMyth\" />"
/bin/echo "    <meta name=\"description\" content=\"\" />"
/bin/echo "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />"
/bin/echo "    <title>MiniMyth Frontend Status</title>"
/bin/echo "    <style type=\"text/css\" title=\"main-styles\">"
/bin/echo "      @import \"../css/minimyth.css\";"
/bin/echo "      @import \"../css/status.css\";"
/bin/echo "    </style>"
/bin/echo "  </head>"
/bin/echo "  <body>"
/bin/echo "    <div class=\"main\">"
/bin/echo "      <div class=\"header\">"
/bin/echo "        <div class=\"heading\">MiniMyth from <a href=\"http://minimyth.org/\">minimyth.org</a></div>"
/bin/echo "        <div class=\"menu\">"
/bin/echo "          <span class=\"menuItemFirst\"><a href=\"../index.shtml\">Home</a></span>"
/bin/echo "          <span class=\"menuItem\"     >Status</span>"
/bin/echo "        </div>"
/bin/echo "        <div class=\"note\">"
/bin/echo "          ${page_date}<br />"
/bin/echo "          ${page_host}<br />"
/bin/echo "          ${MM_VERSION}"
/bin/echo "        </div>"
/bin/echo "      </div>"
/bin/echo "      <div class=\"middle\">"
/bin/echo "        <div class=\"heading\">MiniMyth Frontend Status</div>"
/bin/echo "        <div class=\"section\">"
/bin/echo "          <div class=\"heading\">${status_sensors_head}</div>"
/bin/echo "          <div class=\"status\">"
/bin/echo "${status_sensors_body}"
/bin/echo "          </div>"
/bin/echo "        </div>"
/bin/echo "        <div class=\"section\">"
/bin/echo "          <div class=\"heading\">${status_loads_head}</div>"
/bin/echo "          <div class=\"status\">"
/bin/echo "${status_loads_body}"
/bin/echo "          </div>"
/bin/echo "        </div>"
/bin/echo "      </div> "
/bin/echo "      <div class=\"footer\">"
/bin/echo "        <hr />"
/bin/echo "        Last Updated: 2008-05-17 &lt;webmaster at minimyth dot org&gt;"
/bin/echo "      </div>"
/bin/echo "    </div>"
/bin/echo "  </body>"
/bin/echo "</html>"
