cd tcl${surum}
rm -rf pkgs/sqlite3*
cd unix
./configure --prefix=/usr --mandir=/usr/share/man --enable-threads --enable-64bit
make
