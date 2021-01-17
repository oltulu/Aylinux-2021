cat >> doc/sample.wgetrc <<EOF

# default root certs location
ca_certificate=/tools/etc/ssl/certs/ca-certificates.crt
EOF
export OPENSSL_CFLAGS='-I/tools/include'
export OPENSSL_LIBS='/tools/lib/libssl.so /tools/lib/libcrypto.so'
./configure --prefix=/tools \
--sysconfdir=/tools/etc \
--with-ssl=openssl \
--disable-pcre2 \
--without-libpsl \
--disable-rpath \
--disable-nls \
--disable-debug
make

