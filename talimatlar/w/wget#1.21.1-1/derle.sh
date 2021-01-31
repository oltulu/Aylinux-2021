cat >> doc/sample.wgetrc <<EOF

# default root certs location
ca_certificate=/etc/ssl/certs/ca-certificates.crt
EOF
export OPENSSL_CFLAGS='-I/include'
export OPENSSL_LIBS='/usr/lib/libssl.so /usr/lib/libcrypto.so'
./configure --prefix=/usr \
--sysconfdir=/etc \
--with-ssl=openssl \
--disable-pcre2 \
--without-libpsl \
--disable-rpath \
--disable-nls \
--disable-debug
make

