./configure \
    --prefix=/usr \
    --libdir=/usr/lib \
    --bindir=/usr/bin \
    --sbindir=/usr/bin \
    --localstatedir=/var \
    --enable-usrdir-path \
    --enable-fs-paths-default=/usr/bin:/usr/local/bin \
    --disable-{login,su,sulogin,nologin,runuser} \
    --disable-chfn-chsh \
    --enable-raw \
    --enable-kill \
    --enable-vipw \
    --enable-newgrp \
    --enable-write \
    --enable-mesg \
    --disable-hardlink \
--without-python     \
--without-systemd    \
--without-systemdsystemunitdir

make
