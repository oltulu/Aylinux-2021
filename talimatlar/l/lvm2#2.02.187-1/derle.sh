    CONFIG_SHELL=/bin/bash \
    ./configure --prefix=/usr --sbindir=/usr/bin --sysconfdir=/etc --localstatedir=/var \
                --exec-prefix= \
                --datarootdir=/usr \
                --sbindir=/usr/bin \
                --libdir=/usr/lib \
                --mandir=/usr/share/man \
                --with-udev-prefix=/usr \
                --disable-readline \
                --disable-selinux \
                --enable-pkgconfig \
                --enable-static_link \
                --enable-udev_sync \
                --enable-udev_rules \
                --with-{user,group}=root
make
