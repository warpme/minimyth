#!/bin/sh

. /etc/conf

page_host=`hostname`
page_date=`date +'%Y-%m-%d %H:%M:%S %Z'`

/bin/echo "MiniMyth ${MM_VERSION}"
/bin/echo "from"
/bin/echo "<a href=\"http://linpvr.org/\">LinPVR.org</a><br />"
/bin/echo "${page_host}<br />"
/bin/echo "${page_date}"
