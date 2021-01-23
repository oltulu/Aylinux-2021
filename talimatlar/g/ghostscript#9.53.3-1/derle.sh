# force it to use system libs.
rm -rf cups/libs freetype jbig2dec jpeg lcms2mt libpng openjpeg tiff zlib

# add missing LDFLAGS
sed -i 's/-L$(BINDIR)/& $(LDFLAGS)/g' base/unix-dll.mak

cd ijs
autoreconf -fi
cd ..

./configure ${confopt} --enable-dynamic --with-ijs \
	--with-jbig2dec --with-omni --with-x --with-drivers=ALL \
	--with-fontpath=/usr/share/fonts/Type1:/usr/share/fonts \
	--enable-fontconfig --enable-freetype --enable-openjpeg \
	--with-libpaper --without-luratech --without-omni \
	--with-system-libtiff --disable-compile-inits

# configure libijs
cd ijs
./configure ${confopt} --enable-shared --disable-static
cd ..


# build ghostscript
make ${MAKEJOBS}
make ${MAKEJOBS} so
# build libijs
cd ijs
make ${MAKEJOBS}
cd ..
