mkdir $PKG/usr/share/applications

cat > $PKG/usr/share/applications/ardunoblock.desktop << "EOf"
[Desktop Entry]
Name=Ardunoblock
Comment=Robotik kodlama
Exec=java ./ardublock-aljava -jar /usr/share/arduino/tools/ArduBlockTool/tool/ardublock-all.jarl.jar
Icon=assistant
Terminal=false
Encoding=UTf-8
Type=Application
Categories=Qt;Development;
EOf
