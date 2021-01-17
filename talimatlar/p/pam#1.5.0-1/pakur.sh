cd Linux-PAM-$surum
make DESTDIR=$PKG install

chmod -v 4755 $PKG/usr/bin/unix_chkpwd

cd ${PKG}/usr/lib/security
ln -s pam_unix.so pam_unix_acct.so
ln -s pam_unix.so pam_unix_auth.so
ln -s pam_unix.so pam_unix_passwd.so
ln -s pam_unix.so pam_unix_session.so
