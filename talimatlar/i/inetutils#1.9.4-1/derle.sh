./configure --prefix=/usr \
--libexec=/usr/bin   \
--localstatedir=/var \
--disable-logger     \
--disable-whois      \
--disable-rcp        \
--disable-rexec      \
--disable-rlogin     \
--disable-rsh        \
--disable-servers

make
make check || true
