#!/bin/sh
#
# usefule find grep!
if [ $# -lt 1 ]
then
   echo
   echo "Usage: gf [-i] <searchpattern>"
   echo
   exit
else
   find . -type f -name "*" -print0 | xargs -0 grep -n "$@"
fi

