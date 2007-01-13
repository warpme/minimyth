#!/bin/sh

. /srv/www/cgi-bin/functions

page_host=`hostname`
page_date=`date`
page_path="/cgi-bin/status.cgi"
page_head="Status"

status_sensors_head="Sensors"
status_sensors_body=` \
    /usr/bin/sensors | \
    /bin/sed \
        -e 's/\(\-[1-9][0-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
        -e 's/\(\-[1-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
        -e 's/\(\+[1-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
        -e 's/\(\+[1-4][0-9]\.[0-9] C\)/<span class="temp_cool">\1<\/span>/' \
        -e 's/\(\+[5-6][0-9]\.[0-9] C\)/<span class="temp_warm">\1<\/span>/' \
        -e 's/\(\+[7-9][0-9]\.[0-9] C\)/<span class="temp_hot">\1<\/span>/'`
status_sensors=`output_status "${status_sensors_head}" "${status_sensors_body}"`

status_loads_head="Loads"
status_loads_body=`/bin/cat /proc/loadavg`
status_loads=`output_status "${status_loads_head}" "${status_loads_body}"`

page_body="
${status_sensors}
${status_loads}
<p>
<a href=\"/fs\">browse the MiniMyth filesystem</a>
</p>"

output_page "${page_host}" "${page_date}" "${page_path}" "${page_head}" "${page_body}"
