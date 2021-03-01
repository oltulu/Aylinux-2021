cd $SRC/jre1.8.0_281
install -d $PKG/usr/{bin,share,lib/$isim}
mv bin lib plugin  $PKG/usr/lib/$isim
install -d "$PKG"/usr/lib/mozilla/plugins
# several symlinks
ln -s $isim $PKG/usr/lib/java
ln -s ../lib/java/bin/java $PKG/usr/bin/java
ln -s ../lib/java/bin/javaws $PKG/usr/bin/javaws
ln -s ../lib/java/bin/keytool $PKG/usr/bin/keytool
ln -s ../lib/java/bin/jcontrol $PKG/usr/bin/jcontrol
sed -e "s|Exec=|Exec=/usr/lib/java/bin/|" -e "s|.png|-jre8.png|" \
    -i $PKG/usr/lib/jre/lib/desktop/applications/*
    mv $PKG/usr/lib/jre/lib/desktop/applications "$PKG"/usr/share/
    #install -m644 "$SRC"/*.desktop "$PKG"/usr/share/applications/
    ln -s /usr/lib/java/lib/amd64/libnpjp2.so "$PKG"/usr/lib/mozilla/plugins/libnpjp2-jre8.so
    # remove broken libraries
  #  rm $PKG/usr/lib/jre/lib/amd64/libavplugin-*.so
