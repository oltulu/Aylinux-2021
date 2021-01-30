autoreconf -i
PYTHONPROG=/usr/bin/python ./configure --prefix=/usr \
--sysconfdir=/etc --sbindir=/usr/bin \
--mandir=/usr/share/man \
--enable-ucd-snmp-compatibility \
--enable-ipv6 \
--with-python-modules \
--with-default-snmp-version="3" \
--with-sys-contact="root@localhost" \
--with-sys-location="Unknown" \
--with-logfile="/var/log/snmpd.log" \
--with-mib-modules="host misc/ipfwacc ucd-snmp/diskio tunnel ucd-snmp/dlmod ucd-snmp/lmsensorsMib" \
--with-persistent-directory="/var/net-snmp"
make NETSNMP_DONT_CHECK_VERSION=1
