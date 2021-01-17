mv -v ${isim}_sdk_${surum} ${isim}-${surum}
cd $SRC/${isim}-${surum}
patch -Np0 -i "$SRC/fix-memleak-in-plugin-scanning.patch"
sed -e "s#-O2#${CFLAGS} ${LDFLAGS}#" -i src/Makefile
cd src
make targets
