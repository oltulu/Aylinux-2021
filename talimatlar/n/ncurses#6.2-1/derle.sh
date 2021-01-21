sed -i s/mawk// configure
./configure --prefix=/usr \
--with-shared   \
--without-debug \
--without-ada   \
--enable-widec  \
--enable-overwrite 

make
