autoreconf -fi

mkdir -p build ; cd build
export PYTHON=$(command -v python)
export LDFLAGS="$LDFLAGS -lX11"
../configure --prefix=/usr \
--libexec=/usr/lib/libvirt \
--sbindir=/usr/bin \
--without-hal \
--with-storage-lvm \
--with-qemu \
--with-qemu-user=nobody \
--with-qemu-group=kvm \
--without-netcf \
--with-interface \
--with-udev \
--with-apparmor \
--with-qemu  \
--disable-static \
--without-wireshark-dissector

make
