cd "${SRC}"
for dir in *; do
if [ -d "${dir}" ]; then
	pushd "${dir}"
	make DESTDIR="${PKG}" install
	popd
fi    
done

rm -f "${PKG}"/usr/share/fonts/Type1/fonts.*
