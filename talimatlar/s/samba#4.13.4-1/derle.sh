_samba4_idmap_modules=idmap_ad,idmap_rid,idmap_adex,idmap_hash,idmap_tdb2
_samba4_pdb_modules=pdb_tdbsam,pdb_ldap,pdb_ads,pdb_smbpasswd,pdb_wbc_sam,pdb_samba4
_samba4_auth_modules=auth_unix,auth_wbc,auth_server,auth_netlogond,auth_script,auth_samba4

./configure --enable-fhs \
--prefix=/usr \
--sysconfdir=/etc \
--sbindir=/usr/bin \
--libdir=/usr/lib \
--libexecdir=/usr/lib/samba \
--localstatedir=/var \
--with-configdir=/etc/samba \
--with-lockdir=/var/cache/samba \
--with-sockets-dir=/run/samba \
--with-piddir=/run \
--with-ads \
--with-ldap \
--with-winbind \
--with-acl-support \
--enable-cups \
--with-pam \
--with-pammodulesdir=/usr/lib/security \
--bundled-libraries=!tdb,!talloc,!pytalloc-util,!tevent,!popt,!ldb,!pyldb-util \
--with-shared-modules=${_samba4_idmap_modules},${_samba4_pdb_modules},${_samba4_auth_modules} \
--disable-rpath-install 

make
