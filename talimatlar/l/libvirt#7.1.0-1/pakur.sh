DESTDIR="$PKG" ninja -C build install

  mv "$PKG"/etc/{sysconfig,conf.d}
  mkdir "$PKG"/usr/lib/{sysusers,tmpfiles}.d
  echo "g libvirt - -" > "$PKG/usr/lib/sysusers.d/libvirt.conf"
  echo "z /var/lib/libvirt/qemu 0751" > "$PKG/usr/lib/tmpfiles.d/libvirt.conf"

  chown 0:102 "$PKG/usr/share/polkit-1/rules.d"
  chmod 0750 "$PKG/usr/share/polkit-1/rules.d"
  chmod 600 "$PKG"/etc/libvirt/nwfilter/*.xml \
    "$PKG/etc/libvirt/qemu/networks/default.xml"

  # Strip auto-generated UUID, so it will be generated per-install. (reproducible builds)
  sed -i 's|<uuid>.*</uuid>|<uuid></uuid>|' "$PKG"/etc/libvirt/qemu/networks/default.xml

  rm -rf \
    "$PKG/run" \
    "$PKG/var/lib/libvirt/qemu" \
    "$PKG/var/cache/libvirt/qemu" \
    "$PKG/etc/logrotate.d/libvirtd.libxl"

  rm -f "$PKG/etc/libvirt/qemu/networks/autostart/default.xml"

  # move split modules
  mv "$PKG"/usr/lib/libvirt/storage-backend/libvirt_storage_backend_{rbd,gluster}.so "$PKG/../"
  mv "$PKG/usr/lib/libvirt/storage-backend/libvirt_storage_backend_iscsi-direct.so" "$PKG/../"
  mv "$PKG/usr/lib/libvirt/storage-file/libvirt_storage_file_gluster.so" "$PKG/../"
   install -Dv -t "$PKG/usr/lib/libvirt/storage-backend" "$PKG/../libvirt_storage_backend_gluster.so"
  install -Dv -t "$PKG/usr/lib/libvirt/storage-file" "$PKG/../libvirt_storage_file_gluster.so"
   install -Dv -t "$PKG/usr/lib/libvirt/storage-backend" "$PKG/../libvirt_storage_backend_iscsi-direct.so"
   install -Dv -t "$PKG/usr/lib/libvirt/storage-backend" "$PKG/../libvirt_storage_backend_rbd.so"
