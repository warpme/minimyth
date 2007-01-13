#!/bin/sh

. /etc/conf

page_host=`hostname`
page_date=`date +'%Y-%m-%d %H:%M:%S %Z'`

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

/bin/echo "Content-Type"content="text/html; charset=UTF-8"
/bin/echo
/bin/echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"
/bin/echo "<html>"
/bin/echo "  <head>"
/bin/echo "    <meta name=\"author\" content=\"Paul Bender\" />"
/bin/echo "    <meta name=\"copyright\" content=\"2006 Paul Bender &amp; LinPVR.org\" />"
/bin/echo "    <meta name=\"keywords\" content=\"LinPVR,PVR,Linux,MythTV,MiniMyth\" />"
/bin/echo "    <meta name=\"description\" content=\"\" />"
/bin/echo "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />"
/bin/echo "    <title>${page_host}</title>"
/bin/echo "    <style type=\"text/css\">"
/bin/echo "      @import \"../css/linpvr.css\";"
/bin/echo "      @import \"../css/status.css\";"
/bin/echo "    </style>"
/bin/echo "  </head>"
/bin/echo "  <body>"
/bin/echo "    <div class=\"container\">"
/bin/echo "      <div class=\"watermark\">"
/bin/echo "        MiniMyth ${MM_VERSION}"
/bin/echo "        from"
/bin/echo "        <a href=\"http://linpvr.org/\">LinPVR.org</a><br />"
/bin/echo "        ${page_date}"
/bin/echo "      </div>"
/bin/echo "      <div class=\"header\">"
/bin/echo "        <div class=\"banner\">"
/bin/echo "        </div>"
/bin/echo "      </div>"
/bin/echo "      <div class=\"sitemenu\">"
/bin/echo "        <span class=\"siteMenuItem\"><a id=\"a0\" href=\"../index.html\" class=\"active\">Home</a></span>"
/bin/echo "        <span class=\"siteMenuItem\"><a id=\"a1\" href=\"http://${SERVER_ADDR}:8080/\">${page_host}</a></span>"
/bin/echo "        <span class=\"siteMenuItem\"><a id=\"a2\" href=\"../minimyth/index.shtml\">MiniMyth</a></span>"
/bin/echo "        <span class=\"siteMenuItem\"><a id=\"a3\" href=\"http://linpvr.org/forum/\">Forums</a></span>"
/bin/echo "      </div>"
/bin/echo "      <div class=\"pagebody\">"
/bin/echo "        <div class=\"content\">"
/bin/echo "          <div class=\"contentheader\">${page_host}</div>"
/bin/echo "          <div class=\"contentitem\">"
/bin/echo "            <div class=\"contentitemheader\">${status_sensors_head}</div>"
/bin/echo "            <div class=\"status\">"
/bin/echo "              <pre>"
/bin/echo "${status_sensors_body}"
/bin/echo "              </pre>"
/bin/echo "            </div>"
/bin/echo "          </div>"
/bin/echo "          <div class=\"contentitem\">"
/bin/echo "            <div class=\"contentitemheader\">${status_loads_head}</div>"
/bin/echo "            <div class=\"status\">"
/bin/echo "              <pre>"
/bin/echo "${status_loads_body}"
/bin/echo "              </pre>"
/bin/echo "            </div>"
/bin/echo "          </div>"
/bin/echo "          <div class=\"contentitem\">"
/bin/echo "            <div class=\"contentitemheader\">Useful links</div>"
/bin/echo "            <ul>"
/bin/echo "              <li>browse <a href=\"http://${SERVER_ADDR}:8080/\">${page_host}'s filesystem</a></li>"
/bin/echo "              <li>browse the <a href=\"../minimyth/index.shtml\">MiniMyth documentation</a></li>"
/bin/echo "            </ul>"
/bin/echo "          </div>"
/bin/echo "        </div> "
/bin/echo "        <div class=\"footer\">"
/bin/echo "          <hr />"
/bin/echo "          Home |"
/bin/echo "          <a href=\"http://${SERVER_ADDR}:8080/\">${page_host}</a> |"
/bin/echo "          <a href=\"../minimyth/index.html\">MiniMyth</a> |"
/bin/echo "          <a href=\"http://linpvr.org/forum/\">Forums</a>"
/bin/echo "          <br />"
/bin/echo "          Last Updated: 2006-09-11 &lt;<a href=\"mailto:info at linpvr.org\">webmaster at linpvr.org</a>&gt;"
/bin/echo "        </div>"
/bin/echo "      </div>"
/bin/echo "    </div>"
/bin/echo "  </body>"
/bin/echo "</html>"
