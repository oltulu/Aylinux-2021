./configure $confopt \
--with-vardir=/var/db/sudo \
--docdir=/usr/share/doc/sudo-$version \
--with-all-insults \
--with-env-editor \
--with-pam \
--without-sendmail \
--with-passprompt="[sudo] %p kullanıcısının parolası: "

make
