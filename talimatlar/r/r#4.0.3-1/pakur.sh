make DESTDIR="${PKG}" install

# install libRmath.so
cd src/nmath/standalone
make DESTDIR="${PKG}" install

#  Fixup R wrapper scripts.
sed -i "s|${PKG} ||" "${PKG}/usr/bin/R"
rm "${PKG}/usr/lib/R/bin/R"
cd "${PKG}/usr/lib/R/bin"
ln -s ../../../bin/R

# install some freedesktop.org compatibility
install -Dm644 "${SRC}/r.desktop" "${PKG}/usr/share/applications/r.desktop"
install -Dm644 "${SRC}/r.png" "${PKG}/usr/share/pixmaps/r.png"

# move the config directory to /etc and create symlinks
install -d "${PKG}/etc/R"
cd "${PKG}/usr/lib/R/etc"
for i in *; do
	mv -f ${i} "${PKG}/etc/R"
	ln -s /etc/R/${i} ${i}
done

# Install ld.so.conf.d file to ensure other applications access the shared lib
install -Dm644 "${SRC}/R.conf" "${PKG}/etc/ld.so.conf.d/R.conf"
