#!/bin/sh

. /etc/conf

page_host=`hostname`
page_date=`date +'%Y-%m-%d %H:%M:%S %Z'`

server=${HTTP_HOST:-${SERVER_ADDR}}

/bin/echo "Content-Type"content="text/html; charset=UTF-8"
/bin/echo
/bin/echo "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">"
/bin/echo "<html>"
/bin/echo "  <head>"
/bin/echo "    <meta name=\"author\" content=\"Paul Bender\" />"
/bin/echo "    <meta name=\"copyright\" content=\"2006 Paul Bender &amp; LinPVR.org\" />"
/bin/echo "    <meta name=\"keywords\" content=\"LinPVR,PVR,Linux,MythTV,MiniMyth\" />"
/bin/echo "    <meta name=\"description\" content=\"\" />"
/bin/echo "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />"
/bin/echo "    <title>MiniMyth Frontend Software</title>"
/bin/echo "    <style type=\"text/css\" title=\"main-styles\">"
/bin/echo "      @import \"../css/linpvr.css\";"
/bin/echo "      @import \"../css/linpvr-sidebar-hide.css\";"
/bin/echo "    </style>"
/bin/echo "  </head>"
/bin/echo "  <body>"
/bin/echo "    <div class=\"main\">"
/bin/echo "      <div class=\"header\">"
/bin/echo "        <div class=\"heading\">MiniMyth from <a href=\"http://linpvr.org/\">LinPVR.org</a></div>"
/bin/echo "        <div class=\"menu\">"
/bin/echo "          <span class=\"menuItemFirst\"><a href=\"../index.shtml\">Home</a></span>"
/bin/echo "          <span class=\"menuItem\"     >Software</span>"
/bin/echo "        </div>"
/bin/echo "        <div class=\"note\">"
/bin/echo "          ${page_date}<br />"
/bin/echo "          ${page_host}<br />"
/bin/echo "          ${MM_VERSION}"
/bin/echo "        </div>"
/bin/echo "      </div>"
/bin/echo "      <div class=\"middle\">"
/bin/echo "        <div class=\"heading\">MiniMyth Frontend Software</div>"
/bin/echo "        <div class=\"section\">"
/bin/echo "          <div class=\"heading\">Versions and Licenses</div>"
/bin/echo "          <p>"
/bin/echo "            This is a list of all the software built as part of the MiniMyth build process."
/bin/echo "            Depending on the MiniMyth build system configuration options,"
/bin/echo "            some of the software may not have been included in the MiniMyth binary image."
/bin/echo "          </p>"
/bin/echo "          <ul>"
/bin/echo "            <li>"
/bin/echo "              minimyth:"
/bin/echo "              <ul>"
/bin/echo "                <li>"
/bin/echo "                  <strong>minimyth</strong>"
/bin/echo "                  ${MM_VERSION}"
if /usr/bin/test -f /usr/versions/minimyth.conf.mk ; then
    /bin/echo "                  (<a href=\"http://${server}:8080/usr/versions/minimyth.conf.mk\" type=\"text/plain\">minimyth.conf.mk</a>)"
fi
/bin/echo "                  ;"
/bin/echo "                  <a href=\"../minimyth/license.txt\" type=\"text/plain\">license</a>"
/bin/echo "                </li>"
/bin/echo "              </ul>"
/bin/echo "            </li>"
/bin/echo "            <li>"
/bin/echo "            base ('/' and '/usr'):"
if /usr/bin/test -d /usr/versions ; then
    /bin/echo "            <ul>"
    for software in `cd /usr/versions ; ls -1` ; do
        if /usr/bin/test ! "${software}" = "minimyth"         &&
           /usr/bin/test ! "${software}" = "minimyth.conf.mk" ; then
            version=`/bin/cat /usr/versions/${software}`
            if /usr/bin/test "${version}" = "none" ; then
                version=
            fi
            license_list=
            if /usr/bin/test -d /usr/licenses/${software} ; then
                license_list=`cd /usr/licenses/${software} ; ls -1`
            fi
            /bin/echo "                <li>"
            /bin/echo "                  <strong>${software}</strong>"
            /bin/echo "                  ${version}"
            /bin/echo "                  ;"
            for license in ${license_list} ; do
                /bin/echo "                  <a href=\"http://${server}:8080/usr/licenses/${software}/${license}\" type=\"text/plain\">license</a>"
            done
            /bin/echo "                </li>"
        fi
    done
    /bin/echo "              </ul>"
fi
/bin/echo "            </li>"
/bin/echo "            <li>"
/bin/echo "            extras ('/usr/local'):"
if /usr/bin/test -d /usr/local/versions ; then
    /bin/echo "              <ul>"
    for software in `cd /usr/local/versions ; ls -1` ; do
        if /usr/bin/test ! "${software}" = "minimyth"         &&
           /usr/bin/test ! "${software}" = "minimyth.conf.mk" ; then
            version=`/bin/cat /usr/local/versions/${software}`
            if /usr/bin/test "${version}" = "none" ; then
                version=
            fi
            license_list=
            if /usr/bin/test -d /usr/local/licenses/${software} ; then
                license_list=`cd /usr/local/licenses/${software} ; ls -1`
            fi
            /bin/echo "                <li>"
            /bin/echo "                  <strong>${software}</strong>"
            /bin/echo "                  ${version}"
            /bin/echo "                  ;"
            for license in ${license_list} ; do
                /bin/echo "                  <a href=\"http://${server}:8080/usr/local/licenses/${software}/${license}\" type=\"text/plain\">license</a>"
            done
            /bin/echo "                </li>"
        fi
    done
    /bin/echo "              </ul>"
fi
/bin/echo "            </li>"
/bin/echo "          </ul>"
/bin/echo "        </div>"
/bin/echo "      </div>"
/bin/echo "      <div class=\"footer\">"
/bin/echo "        <hr />"
/bin/echo "        Last Updated: 2006-09-30 &lt;<a href=\"mailto:info at linpvr.org\">webmaster at linpvr.org</a>&gt;"
/bin/echo "      </div>"
/bin/echo "    </div>"
/bin/echo "  </body>"
/bin/echo "</html>"
