#!/bin/sh


# make sure X11 is running
osascript <<EOF
tell app "X11"
  activate
end tell
EOF


#start gv
gv "$1"
#xdvi "$1"

