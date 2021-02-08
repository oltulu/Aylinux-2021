    export CONFIG_SHELL=/bin/bash
  
  CONFIG_SHELL=/bin/bash \
    ./configure --prefix=/usr --sbindir=/usr/bin --sysconfdir=/etc --localstatedir=/var \
                --datarootdir=/usr \
                --libdir=/usr/lib \
                --mandir=/usr/share/man \
                --with-udev-prefix=/usr \
                --disable-readline \
                --disable-selinux \
                --enable-pkgconfig \
                --enable-udev_sync \
                --enable-udev_rules \
                    --with-default-dm-run-dir=/run \
    --with-default-locking-dir=/run/lock/lvm \
    --with-default-pid-dir=/run \
    --with-default-run-dir=/run/lvm \
                --with-{user,group}=root
make
