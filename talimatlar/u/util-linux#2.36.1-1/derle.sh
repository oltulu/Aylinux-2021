mkdir -pv $PKG/var/lib/hwclock
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
--prefix=/usr \
--libdir=/usr/lib \
--bindir=/usr/bin \
--sbindir=/usr/bin \
--localstatedir=/var \
--enable-fs-paths-default=/usr/bin:/usr/local/bin \
--disable-chfn-chsh  \
--disable-login      \
--disable-nologin    \
--disable-su         \
--disable-setpriv    \
--disable-runuser    \
--disable-pylibmount \
--disable-static     \
--without-python     \
--without-systemd    \
--without-systemdsystemunitdir

make
