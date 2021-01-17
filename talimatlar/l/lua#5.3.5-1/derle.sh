patch -p1 -i $SRC/liblua.so.patch
sed "s/^R= \$V.4/R= \$V.5/" -i Makefile
# quite a lot of packages still use lua 5.1 API, enable 5.1 compat mode
make MYCFLAGS="$CFLAGS -fPIC -DLUA_COMPAT_5_2 -DLUA_COMPAT_5_1" MYLDFLAGS="$LDFLAGS" linux
