sed -i 's|-m 644 $(LIBRARY)|-m 755 $(LIBRARY)|' libraries/{liblber,libldap,libldap_r}/Makefile.in
sed -i 's|#define LDAPI_SOCK LDAP_RUNDIR LDAP_DIRSEP "run" LDAP_DIRSEP "ldapi"|#define LDAPI_SOCK LDAP_DIRSEP "run" LDAP_DIRSEP "openldap" LDAP_DIRSEP "ldapi"|' include/ldap_defaults.h
sed -i 's|%LOCALSTATEDIR%/run|/run/openldap|' servers/slapd/slapd.{conf,ldif}
sed -i 's|-$(MKDIR) $(DESTDIR)$(localstatedir)/run|-$(MKDIR) $(DESTDIR)/run/openldap|' servers/slapd/Makefile.in

autoconf
./configure --prefix=/usr \
--libexecdir=/usr/lib \
--sysconfdir=/etc \
--localstatedir=/var/lib/openldap \
--sbindir=/usr/bin \
--enable-dynamic --enable-proctitle --with-tls \
--enable-ipv6 --enable-local --with-cyrus-sasl --with-threads \
--enable-syslog --enable-slapd --enable-crypt --enable-spasswd \
--enable-bdb --enable-hdb --enable-overlays=mod \
--disable-static --with-yielding_select=yes --enable-modules

sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool

make
make -C contrib/slapd-modules/nssov OPT="$CFLAGS $CPPFLAGS" prefix=/usr libexecdir=/usr/lib sysconfdir=/etc/openldap
make -C contrib/slapd-modules/autogroup OPT="$CFLAGS $CPPFLAGS" prefix=/usr libexecdir=/usr/lib sysconfdir=/etc/openldap
make -C contrib/slapd-modules/lastbind OPT="$CFLAGS $CPPFLAGS" prefix=/usr libexecdir=/usr/lib sysconfdir=/etc/openldap
make -C contrib/slapd-modules/passwd/sha2 OPT="$CFLAGS $CPPFLAGS" prefix=/usr libexecdir=/usr/lib sysconfdir=/etc/openldap
