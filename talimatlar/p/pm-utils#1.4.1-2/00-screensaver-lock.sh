#!/bin/sh
#
# 00screensaver-lock: lock workstation on hibernate or suspend

username=$USER
userhome=$HOME
export XAUTHORITY="$userhome/.Xauthority"
export DISPLAY=":0"

case "$1" in
  hibernate|suspend)
     su $username -c "xlock" &
  ;;
  thaw|resume)
  ;;
  *) exit $NA
  ;;
esac
