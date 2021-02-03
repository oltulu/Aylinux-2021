
    ./configure \
    --prefix=/usr \
    --libdir=/usr/lib \
    --bindir=/usr/bin \
    --sbindir=/usr/bin \
    --localstatedir=/var \
    --enable-usrdir-path \
    --enable-fs-paths-default=/usr/bin:/usr/local/bin \
                --disable-nls \
                --disable-{login,su,sulogin,nologin,runuser} \
                --disable-chfn-chsh \
                --enable-{write,raw,kill} \
--without-python     \
--without-systemd    \
--without-systemdsystemunitdir

make
