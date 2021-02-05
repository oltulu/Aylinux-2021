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

# Symlinks for backwards compatibility
for b in "${PKG}"/usr/bin/*; do
	ln -s $(basename $b) "${PKG}"/usr/bin/$(basename $b)-qt5
done

mkdir $PKG/usr/share/applications

cat > $PKG/usr/share/applications/assistant-qt.desktop << "EOf"
[Desktop Entry]
Name=Qt5 Asistanı
Comment=Qt5 belgelerini ve örneklerini gösterir
Exec=assistant
Icon=assistant
Terminal=false
Encoding=UTf-8
Type=Application
Categories=Qt;Development;Documentation;
EOf

cat > $PKG/usr/share/applications/designer-qt.desktop << "EOf"
[Desktop Entry]
Name=Qt5 Tasarla
GenericName=Arayüz hazırlayıcı
Comment=Qt5 uygulamaları için arayüz tasarımı
Exec=designer
Icon=designer
mimeType=application/x-designer;
Terminal=false
Encoding=UTf-8
Type=Application
Categories=Qt;Development;
EOf

cat > $PKG/usr/share/applications/linguist-qt.desktop << "EOf"
[Desktop Entry]
Name=Qt5 Dil Ekle
Comment=Qt5 uygulamalarına çeviriler ekleyin
Exec=linguist
Icon=linguist
mimeType=text/vnd.trolltech.linguist;application/x-linguist;
Terminal=false
Encoding=UTf-8
Type=Application
Categories=Qt;Development;
EOf

cat > $PKG/usr/share/applications/qdbusviewer-qt.desktop << "EOf"
[Desktop Entry]
Name=Qt5 QDbus Görüntüleyici
GenericName=D-Bus Hata Ayıklama
Comment=D-Bus Uygulamalarında hata ayıklar
Exec=qdbusviewer
Icon=qdbusviewer
Terminal=false
Encoding=UTf-8
Type=Application
Categories=Qt;Development;Debugger;
EOf


