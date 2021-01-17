make DESTDIR=$PKG install
rm -rf $PKG/var
rm $PKG/usr/lib/xorg/modules/{libexa,libfb,libfbdevhw,libglamoregl,libint10,libshadow,libshadowfb,libvbe,libvgahw,libwfb}.la
rm $PKG/usr/lib/xorg/modules/drivers/modesetting_drv.la
rm $PKG/usr/lib/xorg/modules/extensions/libglx.la