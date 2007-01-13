#!/bin/sh

page_host=`hostname`
server=${HTTP_HOST:-${SERVER_ADDR}}

/bin/echo "<a href=\"http://${server}:8080/\">Filesystem</a>"
