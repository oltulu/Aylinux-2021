cd lua-$surum
patch -p1 -i ../liblua52.so.patch
sed "s/%VER%/${surum%.*}/g;s/%REL%/$surum/g" ../lua52.pc > lua52.pc
sed -e 's:llua:llua5.2:' -e 's:/include:/include/lua5.2:' -i lua52.pc
sed -r -e '/^LUA_(SO|A|T)=/ s/lua/lua5.2/' -e '/^LUAC_T=/ s/luac/luac5.2/' -i src/Makefile
make MYCFLAGS="$CFLAGS -fPIC" MYLDFLAGS="$LDFLAGS" linux
