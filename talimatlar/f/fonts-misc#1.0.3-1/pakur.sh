cd "${SRC}"
for dir in *; do
if [ -d "${dir}" ]; then
	pushd "${dir}"
	make DESTDIR="${PKG}" install
	popd
fi    
done

mv ${PKG}/usr/share/fonts/misc/*.otf ${PKG}/usr/share/fonts/OTF/
