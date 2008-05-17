#!/bin/sh

. /etc/conf

page_host=`/bin/hostname`
page_date=`/bin/date +'%Y-%m-%d %H:%M:%S %Z'`

server=${HTTP_HOST:-${SERVER_ADDR}}

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
/bin/echo "    <title>MiniMyth Frontend Software</title>"
/bin/echo "    <style type=\"text/css\" title=\"main-styles\">"
/bin/echo "      @import \"../css/minimyth.css\";"
/bin/echo "      @import \"../css/minimyth-sidebar-hide.css\";"
/bin/echo "    </style>"
/bin/echo "  </head>"
/bin/echo "  <body>"
/bin/echo "    <div class=\"main\">"
/bin/echo "      <div class=\"header\">"
/bin/echo "        <div class=\"heading\">MiniMyth from <a href=\"http://minimyth.org/\">minimyth.org</a></div>"
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
if /usr/bin/test -f /srv/www/software/base/versions/minimyth.conf.mk ; then
    /bin/echo "                  (<a href=\"../software/base/versions/minimyth.conf.mk\" type=\"text/plain\">minimyth.conf.mk</a>)"
fi
/bin/echo "                  ;"
/bin/echo "                  <a href=\"../minimyth/license.txt\" type=\"text/plain\">license</a>"
/bin/echo "                </li>"
/bin/echo "              </ul>"
/bin/echo "            </li>"
/bin/echo "            <li>"
/bin/echo "            base ('/' and '/usr'):"
if /usr/bin/test -d /srv/www/software/base/versions ; then
    /bin/echo "            <ul>"
    for software in `cd /srv/www/software/base/versions ; /bin/ls -1` ; do
        if /usr/bin/test ! "${software}" = "minimyth"         &&
           /usr/bin/test ! "${software}" = "minimyth.conf.mk" ; then
            version=`/bin/cat /srv/www/software/base/versions/${software}`
            if /usr/bin/test "${version}" = "none" ; then
                version=
            fi
            license_list=
            if /usr/bin/test -d /srv/www/software/base/licenses/${software} ; then
                license_list=`cd /srv/www/software/base/licenses/${software} ; /bin/ls -1`
            fi
            /bin/echo "                <li>"
            /bin/echo "                  <strong>${software}</strong>"
            /bin/echo "                  ${version}"
            /bin/echo "                  ;"
            for license in ${license_list} ; do
                /bin/echo "                  <a href=\"../software/base/licenses/${software}/${license}\" type=\"text/plain\">license</a>"
            done
            /bin/echo "                </li>"
        fi
    done
    /bin/echo "              </ul>"
fi
/bin/echo "            </li>"
/bin/echo "            <li>"
/bin/echo "            extras ('/usr/local'):"
if /usr/bin/test -d /srv/www/software/extras/versions ; then
    /bin/echo "              <ul>"
    for software in `cd /srv/www/software/extras/versions ; /bin/ls -1` ; do
        if /usr/bin/test ! "${software}" = "minimyth"         &&
           /usr/bin/test ! "${software}" = "minimyth.conf.mk" ; then
            version=`/bin/cat /srv/www/software/extras/versions/${software}`
            if /usr/bin/test "${version}" = "none" ; then
                version=
            fi
            license_list=
            if /usr/bin/test -d /srv/www/software/extras/licenses/${software} ; then
                license_list=`cd /srv/www/software/extras/licenses/${software} ; /bin/ls -1`
            fi
            /bin/echo "                <li>"
            /bin/echo "                  <strong>${software}</strong>"
            /bin/echo "                  ${version}"
            /bin/echo "                  ;"
            for license in ${license_list} ; do
                /bin/echo "                  <a href=\"../software/extras/licenses/${software}/${license}\" type=\"text/plain\">license</a>"
            done
            /bin/echo "                </li>"
        fi
    done
    /bin/echo "              </ul>"
fi
/bin/echo "            </li>"
/bin/echo "            <li>"
/bin/echo "            build (natively compiled software used for cross compiling and assembling MiniMyth):"
if /usr/bin/test -d /srv/www/software/build/versions ; then
    /bin/echo "            <ul>"
    for software in `cd /srv/www/software/build/versions ; /bin/ls -1` ; do
        if /usr/bin/test ! "${software}" = "minimyth"         &&
           /usr/bin/test ! "${software}" = "minimyth.conf.mk" ; then
            version=`/bin/cat /srv/www/software/build/versions/${software}`
            if /usr/bin/test "${version}" = "none" ; then
                version=
            fi
            license_list=
            if /usr/bin/test -d /srv/www/software/build/licenses/${software} ; then
                license_list=`cd /srv/www/software/build/licenses/${software} ; /bin/ls -1`
            fi
            /bin/echo "                <li>"
            /bin/echo "                  <strong>${software}</strong>"
            /bin/echo "                  ${version}"
            /bin/echo "                  ;"
            for license in ${license_list} ; do
                /bin/echo "                  <a href=\"../software/build/licenses/${software}/${license}\" type=\"text/plain\">license</a>"
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
/bin/echo "        Last Updated: 2008-05-16 &lt;<a href=\"mailto:info at linpvr.org\">webmaster at linpvr.org</a>&gt;"
/bin/echo "      </div>"
/bin/echo "    </div>"
/bin/echo "  </body>"
/bin/echo "</html>"
