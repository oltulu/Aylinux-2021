export CFLAGS="$CFLAGS -fPIC"

patch -Np1 -i ../0003-Update-saslauthd.conf-location-in-documentation.patch
patch -Np1 -i ../0006-Enable-autoconf-maintainer-mode.patch
patch -Np1 -i ../0010-Update-required-libraries-when-ld-as-needed-is-used.patch
patch -Np1 -i ../0013-Don-t-use-la-files-for-opening-plugins.patch
patch -Np1 -i ../0020-Restore-LIBS-after-checking-gss_inquire_sec_context_.patch
patch -Np1 -i ../0022-Fix-keytab-option-for-MIT-Kerberos.patch
patch -Np1 -i ../0032-Add-with_pgsql-include-postgresql-to-include-path.patch
patch -Np1 -i ../gdbm-errno.patch

rm -f config/config.guess config/config.sub 
rm -f config/ltconfig config/ltmain.sh config/libtool.m4
rm -fr autom4te.cache
libtoolize -c
aclocal -I config
automake -a -c
autoheader
autoconf

./configure --prefix=/usr \
--sbin=/usr/bin \
--mandir=/usr/share/man \
--infodir=/usr/share/info \
--disable-static \
--enable-shared \
--enable-alwaystrue \
--enable-checkapop \
--enable-cram \
--enable-digest \
--disable-otp \
--disable-srp \
--disable-srp-setpass \
--disable-krb4 \
--enable-gssapi \
--enable-auth-sasldb \
--enable-plain \
--enable-anon \
--enable-login \
--enable-ntlm \
--disable-passdss \
--disable-macos-framework \
--with-pam \
--with-saslauthd=/var/run/saslauthd \
--with-ldap \
--with-dbpath=/var/lib/sasl/sasldb2 \
--with-dblib=gdbm \
--with-configdir=/etc/sasl2:/etc/sasl:/usr/lib/sasl2 \
--sysconfdir=/etc \
--with-devrandom=/dev/urandom

sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool
make
