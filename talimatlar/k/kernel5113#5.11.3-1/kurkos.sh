#!/bin/bash
surum=5.11.3
sonek=aylinux
depmod ${surum}-$sonek
cd /boot

initr="initrd"

[ -f /usr/bin/dracut ] && dracut -N --force --xz --omit systemd -f /boot/${initr}.img-${surum} $surum-$sonek
[ -f /usr/bin/os-prober ] && os-prober
[ -f /usr/bin/grub-mkconfig ] && grub-mkconfig -o /boot/grub/grub.cfg

cd -
