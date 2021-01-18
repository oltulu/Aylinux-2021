#!/bin/sh
[ "$DESKTOP_SESSION" == "xfce" ] && xfconf-query -c xfce4-session -p /general/LockCommand -s xlock
