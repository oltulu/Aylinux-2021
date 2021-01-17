install -dm 755 "$PKG"/usr/include/ZenLib
install -m 644 "$SRC"/ZenLib/Source/ZenLib/*.h "$PKG"/usr/include/ZenLib

for i in HTTP_Client Format/Html Format/Http; do
  install -dm0755 "$PKG"/usr/include/ZenLib/$i
  install -m0644 "$SRC"/ZenLib/Source/ZenLib/$i/*.h "$PKG"/usr/include/ZenLib/$i
done

install -dm 755 "$PKG"/usr/lib/pkgconfig
install -m 644 "$SRC"/ZenLib/Project/GNU/Library/libzen.pc "$PKG"/usr/lib/pkgconfig

sed -i -e 's|Version: $|Version: '$surum'|g' "$PKG"/usr/lib/pkgconfig/libzen.pc
