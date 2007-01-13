#!/bin/sh
hostname=`hostname`
date=`date`
echo "Content-Type"content="text/html; charset=iso-8859-1"
echo 
cat <<EOF
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <style type="text/css" title="Default" media="all">
  <!--
  h2.status {
    font-size:18px;
    font-weight:800;
    color:#360;
    border:none;
    letter-spacing:0.3em;
    padding:0px;
    margin-bottom:10px;
    margin-top:0px;
  }
  div.status {
    width:450px;
    border-top:1px solid #000;
    border-right:1px solid #000;
    border-bottom:1px solid #000;
    border-left:10px solid #000;
    padding:10px;
    margin-bottom:30px;
    -moz-border-radius:8px 0px 0px 8px;
  }
  -->
  </style>
  <title>MiniMyth Status - $hostname - $date </title>
</head>
<body>

  <h1>Status for $hostname</h1>

  <div class="status">
    <h2 class="status">Sensors Output</h2>
    <pre>
`sensors | sed -e 's/^ERROR:.*//' -e 's/\(\+[1234]....C\)/<span style="color: rgb(0, 102, 0); font-weight: bold;">\1<\/span>/' -e 's/\(\+[56]....C\)/<span style="color: rgb(205, 127, 0); font-weight: bold;">\1<\/span>/' -e 's/\(\+[78]....C\)/<span style="color: rgb(255, 0, 0); font-weight: bold;">\1<\/span>/'`
    </pre>
  </div>
  <div class="status">
    <h2 class="status">Load Average Output</h2>
    <pre>
`cat /proc/loadavg`
    </pre>
  </div>

  <p>
    browsable directories:
    <a href="/etc">etc</a>
    <a href="/log">log</a>
    <a href="/tmp">tmp</a>
  </p>

  <h1>@mm_NAME_PRETTY@</h1>

</body>
</html>

EOF
