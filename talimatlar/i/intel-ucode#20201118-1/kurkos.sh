#!/bin/sh
[ ! -d /usr/lib/dracut ] && exit 1
[ ! -f /usr/lib/dracut/dracut.conf.d/intel_ucode.conf ] && echo "early_microcode=yes" >>  /usr/lib/dracut/dracut.conf.d/intel_ucode.conf
