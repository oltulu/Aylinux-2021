./configure --enable-fhs \
                --prefix=/usr \
                --libexecdir=/usr/lib \
                --localstatedir=/var \
                --sysconfdir=/etc \
                --with-privatedir=/etc/samba/private \
                --bundled-libraries=!tdb,!talloc,!tevent,!popt,!ldb,!cmocka \
                --without-{ad-dc,ads,ldap} \
                --without-json

    /usr/bin/python3 ./buildtools/bin/waf build
    /usr/bin/python3 ./buildtools/bin/waf install --destdir=$PKG

make
