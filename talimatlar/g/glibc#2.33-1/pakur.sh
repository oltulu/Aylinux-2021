cd ${SRC}/glibc-${surum}/build

make install_root=$PKG install
	
	mkdir -p $PKG/etc
	cp -v ../nscd/nscd.conf $PKG/etc/nscd.conf
	mkdir -pv $PKG/var/cache/nscd

	touch $PKG/etc/ld.so.conf

	mkdir -pv $PKG/usr/lib/locale

	cp $SRC/glibc.locales.destek \
	../localedata/SUPPORTED

	make install_root=$PKG localedata/install-locales

cat > $PKG/etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF


cat > $PKG/etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/lib
/lib64
/usr/lib
/usr/lib64
/usr/local/lib
/usr/local/lib64

# Add an include directory
include /etc/ld.so.conf.d/*.conf
# End of  /etc/ld.so.conf
EOF

	mkdir $PKG/etc/ld.so.conf.d
	rm -rf $PKG/usr/share/info

# GLIBC STRIPPING

save_lib="ld-$surum.so libc-$surum.so libpthread-$surum.so libthread_db-1.0.so"

cd $PKG/usr/lib

for LIB in $save_lib; do
    objcopy --only-keep-debug $LIB $LIB.dbg 
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB 
done    

unset LIB save_lib

find $PKG/usr/lib -type f -name \*.a -exec strip --strip-debug {} ';'

find $PKG/usr/lib -type f \( -name \*.so* -a ! -name \*dbg \) -exec strip --strip-unneeded {} ';'

find $PKG/usr/bin -type f -exec strip --strip-all {} ';'

cd -
