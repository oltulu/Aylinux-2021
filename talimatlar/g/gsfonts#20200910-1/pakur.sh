cd $SRC/urw-base35-fonts-master
install -Dt "${PKG}/usr/share/fonts/${isim}" -m644 fonts/*.otf
install -Dt "${PKG}/usr/share/metainfo" -m644 appstream/*.xml

install -d "${PKG}"/etc/fonts/conf.{avail,d}
for _f in fontconfig/*.conf; do
	_fn="${PKG}/etc/fonts/conf.avail/69-${_f##*/}"
	install -m644 ${_f} "${_fn}"
	ln -srt "${PKG}/etc/fonts/conf.d" "${_fn}"
done
