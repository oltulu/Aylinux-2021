 mkdir -p $PKG/etc/{rc.d,ntp} \
      $PKG/var/log \
      $PKG/var/run/ntp \
      $PKG/var/lib/ntp/stats \
      $PKG/usr/share/man/{man8,man5}

   patch -p1 -i ../ntp-64bit.diff

   ./configure \
      --prefix=/usr \
      --libexecdir=/usr/lib/ntp \
      --with-sntp \
      --with-crypto \
      --without-ntpsnmpd \
      --enable-debugging=no \
      --enable-ntpdate-step \
      --enable-parse-clocks \
      --enable-all-clocks \
      --enable-ipv6 \
      --enable-ntp-signd \
      CFLAGS="$CFLAGS" \
      LDFLAGS="$LDFLAGS" 

   # substitute the default configuration path
   sed -i -e 's;\(CONFIG_FILE[^"]*"\)/etc/ntp.conf;\1/etc/ntp/ntp.conf;' \
        include/ntp_config.h

   make
