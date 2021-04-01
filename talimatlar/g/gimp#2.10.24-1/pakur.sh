install -D -m644 "/sources/linux.gpl" "${PKG}/usr/share/gimp/2.0/palettes/Linux.gpl"
ln -s gimptool-2.0 "${PKG}/usr/bin/gimptool"
rm $PKG/usr/share/gimp/2.0/images/gimp-splash.png
cp /sources/gimp-splash.png $PKG/usr/share/gimp/2.0/images/gimp-splash.png


cat > $PKG/usr/share/applications/gimp-screenshot-plugin.desktop << EOF 
[Desktop Entry] 
Type=Application 
Name=GIMP ekran resmi eklentisi
Exec=/usr/lib/gimp/2.0/plug-ins/screenshot/screenshot 
NoDisplay=true 
X-KDE-DBUS-Restricted-Interfaces=org.kde.kwin.Screenshot 

EOF
