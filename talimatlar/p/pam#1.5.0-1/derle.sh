cd Linux-PAM-$surum
./configure --prefix=/usr --sysconfdir=/etc \
            --libdir=/usr/lib            \
             --sbindir=/usr/bin          \
            --enable-securedir=/usr/lib/security \
            --disable-regenerate-docu        \
            --docdir=/usr/share/doc/Linux-PAM-$surum

make
