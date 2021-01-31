cd expect${surum}
cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure
./configure \
--prefix=/usr \
--with-tcl=/usr/lib \
--with-tclinclude=/usr/include
make
make test
