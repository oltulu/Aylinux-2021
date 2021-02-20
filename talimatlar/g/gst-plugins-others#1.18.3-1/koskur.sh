#!/bin/sh
[ -d /var/lib/mps/db/gst-plugins-bad ]  && mps sil gst-plugins-bad --ona
#[ -d /var/lib/mps/db/gst-plugins-good ] && mps sil gst-plugins-good --ona
#[ -d /var/lib/mps/db/gst-plugins-ugly ] && mps sil gst-plugins-ugly --ona
[ -d /var/lib/mps/db/gst-libav ]  &&  mps sil gst-libav --ona
[ -d /var/lib/mps/db/gst-python ] &&  mps sil gst-python --ona
