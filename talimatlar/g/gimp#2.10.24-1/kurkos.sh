cat > /usr/share/applications/gimp-screenshot-plugin.desktop << EOF 
[Desktop Entry] Type=Application 
Name=GIMP Screenshot Plugin 
Exec=/usr/lib/gimp/2.0/plug-ins/screenshot/screenshot 
NoDisplay=true 
X-KDE-DBUS-Restricted-Interfaces=org.kde.kwin.Screenshot 
EOF
