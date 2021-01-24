 ./configure --prefix=/usr \
                --with-rsh=ssh \
                --with-included-zlib=no \
                --with-included-popt=yes \
                --disable-xxhash \
                --disable-lz4 \
                --disable-zstd
make 
