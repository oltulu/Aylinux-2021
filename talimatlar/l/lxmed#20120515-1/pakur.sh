cat > ${isim}.desktop << EOF
[Desktop Entry]
Encoding=UTF-8
Exec=lxmed
Icon=lxmed
Type=Application
Terminal=false
Name=Menü Düzenleyici
GenericName=Menü Düzenleyici
StartupNotify=false
Categories=Settings;DesktopSettings;X-LXDE-Settings;
EOF

cat > %{isim} << 'EOF'
#!/bin/sh
pkexec java -jar /usr/bin/LXMenuEditor.jar "$@"
EOF

betik  = install -D -m644 ${isim}.desktop $PKG/usr/share/applications/${isim}.desktop
betik  = install -D -m644 ${isim} $PKG/usr/bin/${isim}
betik     = cd "${SRC}"/${isim}/content 
betik  = install -D -m644 ${isim}.png "${PKG}"/opt/${isim}/${isim}.png
