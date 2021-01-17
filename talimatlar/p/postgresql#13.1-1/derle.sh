patch -p1 < ../postgresql-run-socket.patch
patch -p1 < ../postgresql-perl-rpath.patch

options=(
--prefix=/usr
--mandir=/usr/share/man
--datadir=/usr/share/postgresql
--sysconfdir=/etc
--with-gssapi
--with-libxml
--with-openssl
--with-perl
--with-python
--with-tcl
--with-pam
--with-system-tzdata=/usr/share/zoneinfo
--with-uuid=e2fs
--with-icu
--with-ldap
--with-llvm
--enable-nls
--enable-thread-safety
--disable-rpath
)

./configure ${options[@]} PYTHON=/usr/bin/python3
make world
