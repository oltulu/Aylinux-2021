
cd $SRC

  DESTDIR="$PKG" meson install -C build

  # we'll create this on installation
  rmdir "$PKG"/var/log/journal/remote

  # runtime libraries shipped with systemd-libs
  install -d -m0755 systemd-libs
  mv "$PKG"/usr/lib/lib{nss,systemd,udev}*.so* systemd-libs

  # manpages shipped with systemd-sysvcompat
  rm "$PKG"/usr/share/man/man8/{halt,poweroff,reboot,shutdown}.8

  # executable (symlinks) shipped with systemd-sysvcompat
  rm "$PKG"/usr/bin/{halt,init,poweroff,reboot,shutdown}

  # files shipped with systemd-resolvconf
  rm "$PKG"/usr/{bin/resolvconf,share/man/man1/resolvconf.1}

  # avoid a potential conflict with [core]/filesystem
  rm "$PKG"/usr/share/factory/etc/{issue,nsswitch.conf}
  sed -i -e '/^C \/etc\/nsswitch\.conf/d' \
    -e '/^C \/etc\/issue/d' "$PKG"/usr/lib/tmpfiles.d/etc.conf

  # add back tmpfiles.d/legacy.conf, normally omitted without sysv-compat
  install -m0644 $isim-stable/tmpfiles.d/legacy.conf "$PKG"/usr/lib/tmpfiles.d

  # ship default policy to leave services disabled
  echo 'disable *' >"$PKG"/usr/lib/systemd/system-preset/99-default.preset

  # add mkinitcpio hooks
  install -D -m0644 initcpio-install-systemd "$PKG"/usr/lib/initcpio/install/systemd
  install -D -m0644 initcpio-install-udev "$PKG"/usr/lib/initcpio/install/udev
  install -D -m0644 initcpio-hook-udev "$PKG"/usr/lib/initcpio/hooks/udev

  install -d -o root -g root -m 2755 "$PKG"/var/log/journal

  # match directory owner/group and mode from [extra]/polkit
  install -d -o root -g 102 -m 0750 "$PKG"/usr/share/polkit-1/rules.d

  # add example bootctl configuration
  install -D -m0644 arch.conf "$PKG"/usr/share/systemd/bootctl/arch.conf
  install -D -m0644 loader.conf "$PKG"/usr/share/systemd/bootctl/loader.conf
  install -D -m0644 splash-arch.bmp "$PKG"/usr/share/systemd/bootctl/splash-arch.bmp

  # pacman hooks
  install -D -m0755 systemd-hook "$PKG"/usr/share/libalpm/scripts/systemd-hook
  install -D -m0644 -t "$PKG"/usr/share/libalpm/hooks *.hook

  # overwrite the systemd-user PAM configuration with our own
  install -D -m0644 systemd-user.pam "$PKG"/etc/pam.d/systemd-user

  install -d -m0755 "$PKG"/usr
  mv systemd-libs "$PKG"/usr/lib

  install -d -m0755 "$PKG"/usr/bin
  ln -s resolvectl "$PKG"/usr/bin/resolvconf

  install -d -m0755 "$PKG"/usr/share/man/man1
  ln -s resolvectl.1.gz "$PKG"/usr/share/man/man1/resolvconf.1.gz

  install -D -m0644 -t "$PKG"/usr/share/man/man8 \
    build/man/{halt,poweroff,reboot,shutdown}.8

  install -d -m0755 "$PKG"/usr/bin
  ln -s ../lib/systemd/systemd "$PKG"/usr/bin/init
  for tool in halt poweroff reboot shutdown; do
    ln -s systemctl "$PKG"/usr/bin/$tool
  done
