make DESTDIR=$PKG docdir=/usr/share/doc/$isim-$surum-release install

for res in 16 32 48 128; do
    install -D -m644 "$SRC/vlc-$surum/share/icons/${res}x${res}/vlc.png" \
    "$PKG/usr/share/icons/hicolor/${res}x${res}/apps/vlc.png"
done

# Obsolets libs
rm $PKG/usr/lib/libvlc{,core}.la
rm $PKG/usr/lib/vlc/libcompat.la
rm $PKG/usr/lib/vlc/libvlc{_pulse,_vdpau,_xcb_events}.la
