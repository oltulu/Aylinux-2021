export _nsprver=4.21

mkdir -p $PKG/usr/lib/pkgconfig
mkdir -p $PKG/usr/bin
mkdir -p $PKG/usr/include/nss

NSS_VMAJOR=$(grep "#define.*NSS_VMAJOR" nss/lib/nss/nss.h | awk '{print $3}')
NSS_VMINOR=$(grep "#define.*NSS_VMINOR" nss/lib/nss/nss.h | awk '{print $3}')
NSS_VPATCH=$(grep "#define.*NSS_VPATCH" nss/lib/nss/nss.h | awk '{print $3}')

sed ${SRC}/nss.pc.in \
-e "s,%libdir%,/usr/lib,g" \
-e "s,%prefix%,/usr,g" \
-e "s,%exec_prefix%,/usr/bin,g" \
-e "s,%includedir%,/usr/include/nss,g" \
-e "s,%NSPR_VERSION%,${_nsprver},g" \
-e "s,%NSS_VERSION%,${surum},g" > \
${PKG}/usr/lib/pkgconfig/nss.pc

ln -sf nss.pc ${PKG}/usr/lib/pkgconfig/mozilla-nss.pc
chmod 644 ${PKG}/usr/lib/pkgconfig/*.pc

sed ${SRC}/nss-config.in \
	-e "s,@libdir@,/usr/lib,g" \
	-e "s,@prefix@,/usr/bin,g" \
	-e "s,@exec_prefix@,/usr/bin,g" \
	-e "s,@includedir@,/usr/include/nss,g" \
	-e "s,@MOD_MAJOR_VERSION@,${NSS_VMAJOR},g" \
	-e "s,@MOD_MINOR_VERSION@,${NSS_VMINOR},g" \
	-e "s,@MOD_PATCH_VERSION@,${NSS_VPATCH},g" \
	> ${PKG}/usr/bin/nss-config
chmod 755 ${PKG}/usr/bin/nss-config

for f in libsoftokn3.so libfreebl3.so libnss3.so libnssutil3.so \
	libssl3.so libsmime3.so libnssckbi.so libnssdbm3.so; do
	install -m755 dist/*.OBJ/lib/${f} ${PKG}/usr/lib
done

install -m644 dist/*.OBJ/lib/libcrmf.a ${PKG}/usr/lib

for f in certutil cmsutil crlutil modutil pk12util shlibsign \
	signtool signver ssltap; do
	install -m755 dist/*.OBJ/bin/${f} ${PKG}/usr/bin
done

install -m644 dist/public/nss/*.h ${PKG}/usr/include/nss
