
    ./configure --prefix=/usr \
                --disable-nls \
                --disable-{login,su,sulogin,nologin,runuser} \
                --disable-chfn-chsh \
                --enable-{write,raw,kill} \
--without-python     \
--without-systemd    \
--without-systemdsystemunitdir

make
