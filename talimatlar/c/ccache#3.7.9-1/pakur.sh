install -Dm 755 ccache -t "${PKG}/usr/bin"
install -Dm 644 doc/ccache.1 -t "${PKG}/usr/share/man/man1"

install -d "${PKG}/usr/lib/ccache/bin"

for _prog in gcc g++ c++; do
	ln -s /usr/bin/ccache "${PKG}/usr/lib/ccache/bin/$_prog"
	ln -s /usr/bin/ccache "${PKG}/usr/lib/ccache/bin/${CHOST}-$_prog"
done
for _prog in cc clang clang++; do
	ln -s /usr/bin/ccache "${PKG}/usr/lib/ccache/bin/$_prog"
done
