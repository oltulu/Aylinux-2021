cd $SRC
rm -rf ghc-$surum
LANG=en_US.UTF-8 bsdtar xf /sources/ghc-${surum}-src.tar.xz -C .

cd ghc-$surum

cp mk/build.mk{.sample,}

sed -i '1iBuildFlavour = perf' mk/build.mk

cat >> mk/build.mk <<-EOF
	INTEGER_LIBRARY      = integer-gmp
	BeConservative       = YES
	GhcStage3HcOpts     += -O3
	SplitSections        = YES
	HADDOCK_DOCS         = NO
	BUILD_SPHINX_HTML    = NO
	BUILD_SPHINX_PS      = NO
	BUILD_SPHINX_PDF     = NO
EOF

autoreconf -fi

./configure \
--prefix=/usr \
--with-system-libffi \
--with-ffi-includes=$(pkg-config --variable=includedir libffi)
make
