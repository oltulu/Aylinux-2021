cd $SRC/${isim/5-/}-everywhere-src-${surum}
# install missing icons and desktop files
for icon in src/linguist/linguist/images/icons/linguist-*-32.png ; do
	size=$(echo $(basename ${icon}) | cut -d- -f2)
	install -p -D -m644 ${icon} "${PKG}/usr/share/icons/hicolor/${size}x${size}/apps/linguist.png"
done

install -D -m644 src/designer/src/designer/images/designer.png \
"${PKG}/usr/share/icons/hicolor/128x128/apps/QtProject-designer.png"
install -D -m644 src/qdbus/qdbusviewer/images/qdbusviewer.png \
"${PKG}/usr/share/icons/hicolor/32x32/apps/qdbusviewer.png"
install -D -m644 src/qdbus/qdbusviewer/images/qdbusviewer-128.png \
"${PKG}/usr/share/icons/hicolor/128x128/apps/qdbusviewer.png"
install -d "${PKG}/usr/share/applications"
install -m644 "${SRC}"/{linguist,designer,assistant,qdbusviewer}.desktop \
"${PKG}/usr/share/applications/"

# Symlinks for backwards compatibility
for b in "${PKG}"/usr/bin/*; do
	ln -s $(basename $b) "${PKG}"/usr/bin/$(basename $b)-qt5
done
