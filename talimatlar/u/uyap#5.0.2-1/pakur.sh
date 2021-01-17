# Başlatıcı 
mkdir -pv $PKG/usr/share/applications &&
cat > $PKG/usr/share/applications/$isim.desktop << "EOF" &&
#!/usr/bin/env xdg-open
[Desktop Entry]
Comment[tr]=Uyap Belge Düzenleyici
Comment=
Exec=/usr/share/UYAPEditor/dokuman.sh
Icon=uyap-editor
GenericName[tr]=Uyap Belge Düzenleyici
GenericName=Uyap Belge Düzenleyici
Name[tr]=Uyap Belge Düzenleyici
Name=UYAP Dokuman Editor
MimeType=application/udf;
Categories=TextEditor;Office;
Type=Application
Terminal=false
EOF

# Bin Dosyası 
#mkdir -pv $PKG/usr/bin &&
#cat > $PKG/usr/bin/$isim << "EOF" &&
#java -Xmx512m -Duser.language=tr -Duser.region=TR -cp .:/opt/uki/editor_lib2.jar:/opt/uki/editor_lib.jar:/opt/uki/editor_laf.jar:/opt/uki/jai_hvl.jar:/opt/uki/editor_utility.jar:/opt/uki/jdom.jar:/opt/uki/updater.jar tr.com.havelsan.uyap.system.editor.common.WPAppManager "getNewWPInstance" "EDITOR_TYPE_DOCUMENT" "$1" "$2"
#EOF

# Uyap Menü 
mkdir -pv $PKG/usr/share/menu &&
#cat > $PKG/usr/share/menu/$isim.menu << "EOF" &&
#?package(uyap):needs="x11" \
#  section="Office" \
#  hints="Metin Düzenleyici" \
#  title="Uyap Belge Düzenleyici" \
#  icon="/opt/uki/product_logo_32.xpm" \
#  command="/usr/bin/uyap"
#EOF

# Uyap Mime 
mkdir -pv $PKG/usr/share/mime/packages &&
cat > $PKG/usr/share/mime/packages/udf.xml << "EOF" &&
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns='http://www.freedesktop.org/standards/shared-mime-info'>
	<mime-type type="application/udf">
		<comment>Uyap Document File</comment>
  		<comment xml:lang="tr">Uyap Belge Dosyası</comment>
  		<acronym>UDF</acronym>
  		<expanded-acronym>Uyap Document File</expanded-acronym>
  		<generic-icon name="uyap-editor"/>
  		<glob pattern="*.udf"/>
	</mime-type>

	<mime-type type="application/usf">
		<comment>Uyap Template File</comment>
  		<comment xml:lang="tr">Uyap Şablon Dosyası</comment>
  		<acronym>USF</acronym>
  		<expanded-acronym>Uyap Template File</expanded-acronym>
  		<generic-icon name="uyap-editor"/>
  		<glob pattern="*.usf"/>
	</mime-type>
</mime-info>
EOF

#chmod +x $PKG/usr/bin/uyap
