#export NETSNMP_DONT_CHECK_VERSION=1
	./configure --prefix=/usr \
				--sysconfdir=/etc --sbindir=/usr/bin \
				--enable-shared \
				--disable-embedded-perl \
				--with-perl-modules \
				--without-rpm \
				--with-openssl \
				--with-zlib \
				--with-mib-modules="ucd-snmp/lmsensorsMib smux agentx ucd-snmp/diskio" \
				--with-sys-location="Unknown" \
				--with-sys-contact="root@localhost" \
				--with-default-snmp-version="3" \
				--with-logfile=/var/log/snmp/snmpd.log \
				--with-persistent-directory=/var/lib/snmp \
				--with-ldflags="-lsensors"
	make -j1
  
