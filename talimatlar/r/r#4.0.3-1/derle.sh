sed -i 's|$(rsharedir)/texmf|${datarootdir}/texmf|' share/Makefile.in
./configure  --prefix=/usr \
	--libdir=/usr/lib \
	--sysconfdir=/etc/R \
	--datarootdir=/usr/share \
	rsharedir=/usr/share/R/ \
	rincludedir=/usr/include/R/ \
	rdocdir=/usr/share/doc/R/ \
	--with-x \
	--enable-R-shlib \
	--with-lapack \
	--with-blas \
	F77=gfortran \
	LIBnn=lib
make

# make libRmath.so
cd src/nmath/standalone
make shared
