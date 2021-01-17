# from archlinux
patch -p1 -i ../qt5-base-cflags.patch # Use system CFLAGS
patch -p1 -i ../qtbug-86604.patch # Fix multiscreen issues in Plasma
patch -p1 -i ../qtbug-86319.patch # Fix SIGTRAP with gdb


./configure -confirm-license -opensource -v \
-prefix /usr \
-docdir /usr/share/doc/qt \
-headerdir /usr/include/qt \
-archdatadir /usr/lib/qt \
-datadir /usr/share/qt \
-sysconfdir /etc/xdg \
-examplesdir /usr/share/doc/qt/examples \
-plugin-sql-{psql,mysql,sqlite,odbc} \
-system-sqlite \
-openssl-linked \
-nomake examples \
-no-rpath \
-dbus-linked \
-system-harfbuzz \
-no-mimetype-database \
-no-use-gold-linker \
-reduce-relocations \
-no-strip

make
