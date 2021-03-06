cd debins/build
mkdir $PKG/usr
mkdir $PKG/usr/bin
mv debins uygur
cp -r uygur $PKG/usr/bin/
chmod +x $PKG/usr/bin/uygur
mkdir $PKG/usr/share
mkdir $PKG/usr/share/applications

cat > $PKG/usr/share/applications/uygur.desktop << "EOf"
[Desktop Entry]
Name=Uygulama Kur
Comment=Kur paketlerini kurar
Exec=uygur
Icon=uygur
NoDisplay=true
Terminal=true
Encoding=UTf-8
Type=Application
Categories=Qt;Development;
MimeType=text/html;application/application/x-lzip
EOf
