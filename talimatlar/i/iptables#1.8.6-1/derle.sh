rm include/linux/types.h
	
./configure --prefix=/usr \
  --libexecdir=/usr/lib \
  --enable-libipq \
  --disable-nftables
sed -e 's/ -shared / -Wl,-O1,--as-needed\0/g' -i libtool

make
