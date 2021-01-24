rm include/linux/types.h
	
./configure --prefix=/usr \
  --libexecdir=/usr/lib \
  --sbindir=/usr/bin \
  --enable-libipq \
  --disable-nftables
sed -e 's/ -shared / -Wl,-O1,--as-needed\0/g' -i libtool

make
