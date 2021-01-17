install -vDm 755 release/mumble -t "$PKG/usr/bin"
install -vDm 755 scripts/mumble-overlay -t "$PKG/usr/bin/"
# (vendored) libs
install -vdm 755 "$PKG/usr/lib/mumble/"
local _lib
for _lib in release/*.so*; do
if [ -L "$_lib" ]; then
  cp -vP "$_lib" "$PKG/usr/lib/mumble/"
else
  install -vDm 755 "$_lib" -t "$PKG/usr/lib/mumble/"
fi
done
install -vDm 755 release/plugins/*.so -t "$PKG/usr/lib/mumble/"
# XDG desktop integration
install -vDm 644 scripts/mumble.desktop -t "$PKG/usr/share/applications"
# man page
install -vDm 644 "man/${isim}"*.1 -t "$PKG/usr/share/man/man1/"
# XDG desktop icons
install -vDm 644 icons/mumble.svg -t "$PKG/usr/share/icons/hicolor/scalable/apps/"
