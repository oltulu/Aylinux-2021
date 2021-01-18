export _stagedir="${SRC}/stagedir"

install -dm755 "${PKG}"/usr
cp -a "${_stagedir}"/{bin,include,share} "${PKG}"/usr

install -d "${PKG}"/usr/lib
cp -a "${_stagedir}"/lib/*.a "${PKG}"/usr/lib/
cp -a "${_stagedir}"/lib/cmake "${PKG}"/usr/lib/

install -Dm644 "${_stagedir}"/python3/lib/libboost_*.a "${PKG}"/usr/lib/
cp -a "${_stagedir}"/python3/lib/cmake/* "${PKG}"/usr/lib/cmake/

ln -s /usr/bin/b2 "$PKG"/usr/bin/bjam

install -dm755 "${PKG}"/usr
cp -a "${_stagedir}"/lib "${PKG}"/usr
cp -a "${_stagedir}"/python3/lib/libboost_* "${PKG}"/usr/lib

for _lib in python numpy; do
 ln -srL "${PKG}"/usr/lib/libboost_${_lib}{27,}.so
 ln -srL "${PKG}"/usr/lib/libboost_${_lib}3{7,}.so
done

rm -rf $PKG/usr/share/boostbook
