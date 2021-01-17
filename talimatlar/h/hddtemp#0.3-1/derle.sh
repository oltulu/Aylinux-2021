cd ${isim}-${surum}-beta15
patch -p 1 -i $SRC/hddtemp-0.3-beta15-satacmds.patch
patch -p 1 -i $SRC/hddtemp-0.3-beta15-byteswap.patch
patch -p 1 -i $SRC/hddtemp-0.3-beta15-execinfo.patch
patch -p 1 -i $SRC/hddtemp-0.3-beta15-nls.patch
patch -p 1 -i $SRC/hddtemp-0.3-beta15-iconv.patch
./configure --prefix=/usr --sbindir=/usr/bin --mandir=/usr/share/man --with-db-path="/usr/share/${isim}/hddtemp.db"
make
