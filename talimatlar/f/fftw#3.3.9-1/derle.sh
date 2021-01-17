cd $SRC
  cp -a $isim-$surum $isim-$surum-double
  cp -a $isim-$surum $isim-$surum-long-double
  mv $isim-$surum $isim-$surum-single

# -march/-mtune dizinimizi tutarken yukarı akış varsayılan CFLAGS kullanın.
  CFLAGS+=" -O3 -fomit-frame-pointer -malign-double -fstrict-aliasing -ffast-math"

CONFIGURE="./configure F77=gfortran --prefix=/usr \
--enable-static=no --enable-shared --enable-threads \
--enable-openmp"

# çift duyarlılık inşa etme
  cd $SRC/$isim-$surum-double
  $CONFIGURE --enable-sse2 --enable-avx
  make
  
# inşa ve uzun çift duyarlıklı yükleme
  cd $SRC/$isim-$surum-long-double
  $CONFIGURE --enable-long-double
  make
 
# tek duyarlık oluşturma ve yükleme
  cd $SRC/$isim-$surum-single
  $CONFIGURE --enable-float --enable-sse --enable-avx
  make
