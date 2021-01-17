DESTDIR="${PKG}" ninja -C build-shared install
DESTDIR="${PKG}" ninja -C build-static install
cd "${PKG}"/usr/lib
for lib in *.so; do
ln -sf "${lib}" "${lib}.0"
done
