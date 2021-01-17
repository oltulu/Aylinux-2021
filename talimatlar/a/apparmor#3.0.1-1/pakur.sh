make -C libraries/libapparmor DESTDIR="${PKG}" install
make -C binutils DESTDIR="${PKG}" install
make -C utils DESTDIR=${PKG} BINDIR=${PKG}/usr/bin VIM_INSTALL_PATH="${PKG}/usr/share/vim/vimfiles/syntax" install
make -C parser -j1 DESTDIR=${PKG} APPARMOR_BIN_PREFIX=${PKG}/usr/lib/apparmor SBINDIR=${PKG}/usr/bin USR_SBINDIR=${PKG}/usr/bin install 
make -C profiles DESTDIR=${PKG} install 
rm -rv ${PKG}/usr/lib/perl5/*/core_perl

find "${PKG}/usr/lib/perl5/" -type f -iname "*.so" -exec chmod 755 {} \;
