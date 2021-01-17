rm include/linux/types.h
	
./configure $confopt \
--enable-devel \
--enable-libipq \
--enable-shared 
sed -e 's/ -shared / -Wl,-O1,--as-needed\0/g' -i libtool

make
