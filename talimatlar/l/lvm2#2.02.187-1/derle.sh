    CONFIG_SHELL=/bin/bash \
    ./configure --prefix=/usr \
                --exec-prefix= \
                --datarootdir=/usr \
                --mandir=/usr/share/man \
                --with-udev-prefix= \
                --disable-readline \
                --disable-selinux \
                --enable-pkgconfig \
                --enable-static_link \
                --enable-udev_sync \
                --enable-udev_rules \
                --with-{user,group}=root
make
