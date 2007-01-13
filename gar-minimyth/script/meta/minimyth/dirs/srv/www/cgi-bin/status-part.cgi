#!/bin/sh

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

/bin/echo "<style type=\"text/css\">"
/bin/echo "  @import \"../css/status.css\";"
/bin/echo "</style>"
/bin/echo "<div class=\"contentitem\">"
/bin/echo "  <div class=\"contentitemheader\">${status_sensors_head}</div>"
/bin/echo "  <div class=\"status\">"
/bin/echo "    <pre>"
/bin/echo "${status_sensors_body}"
/bin/echo "    </pre>"
/bin/echo "  </div>"
/bin/echo "</div>"
/bin/echo "<div class=\"contentitem\">"
/bin/echo "  <div class=\"contentitemheader\">${status_loads_head}</div>"
/bin/echo "  <div class=\"status\">"
/bin/echo "    <pre>"
/bin/echo "${status_loads_body}"
/bin/echo "    </pre>"
/bin/echo "  </div>"
/bin/echo "</div>"
