./configure \
    --prefix=/usr \
    --sbindir=/usr/bin \
    --libexecdir=/usr/lib \
    --with-rundir=/run/sudo \
--with-vardir=/var/db/sudo \
--docdir=/usr/share/doc/sudo-$surum \
--with-all-insults \
--with-env-editor \
--with-pam \
--without-sendmail \
--with-passprompt="[sudo] %p kullanıcısının parolası: "

make
