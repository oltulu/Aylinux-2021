 sed -i 's|/sysconfig/|/conf.d/|g' \
    src/remote/libvirtd.service.in \
    tools/{libvirt-guests.service,libvirt-guests.sh,virt-pki-validate}.in \
    src/locking/virtlockd.service.in \
    src/logging/virtlogd.service.in
  sed -i 's|/usr/libexec/qemu-bridge-helper|/usr/lib/qemu/qemu-bridge-helper|g' \
    src/qemu/qemu.conf \
    src/qemu/test_libvirtd_qemu.aug.in

  sed -i 's/notify/simple/' src/remote/libvirtd.service.in

  milis-meson build \
    --libexecdir=lib/libvirt \
    --native-file "$srcdir"/find_programs.ini \
    -Drunstatedir=/run \
    -Dqemu_group=kvm \
    -Dnetcf=disabled \
    -Dopenwsman=disabled \
    -Dapparmor=disabled \
    -Dselinux=disabled \
    -Dwireshark_dissector=disabled \
    -Ddriver_bhyve=disabled \
    -Ddriver_hyperv=disabled \
    -Ddriver_libxl=disabled \
    -Ddriver_vz=disabled \
    -Dsecdriver_apparmor=disabled \
    -Dsecdriver_selinux=disabled \
    -Dstorage_sheepdog=disabled \
    -Dstorage_vstorage=disabled \
    -Ddtrace=disabled \
    -Dnumad=disabled \
    -Dstorage_zfs=enabled \
    -Dstorage_rbd=enabled

  ninja -C build
