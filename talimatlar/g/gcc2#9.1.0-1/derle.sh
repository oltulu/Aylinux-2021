	cd  gcc-$surum
	mv -v ../mpfr-* mpfr
	mv -v ../gmp-* gmp
	mv -v ../mpc-* mpc
	
	cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($ONSISTEM_TARGET-gcc -print-libgcc-file-name)`/include-fixed/limits.h
	
	for file in gcc/config/{linux,i386/linux{,64}}.h
	do
	  cp -uv $file{,.orig}
	  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
		  -e 's@/usr@/tools@g' $file.orig > $file
	  echo '
	#undef STANDARD_STARTFILE_PREFIX_1
	#undef STANDARD_STARTFILE_PREFIX_2
	#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
	#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
	  touch $file.orig
	done

	case $(uname -m) in
	  x86_64)
		sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
	  ;;
	esac

	mkdir -v build
	cd build

	CC=$ONSISTEM_TARGET-gcc                            \
	CXX=$ONSISTEM_TARGET-g++                           \
	AR=$ONSISTEM_TARGET-ar                             \
	RANLIB=$ONSISTEM_TARGET-ranlib                     \
	../configure                                       \
		--prefix=/tools                                \
		--with-local-prefix=/tools                     \
		--with-native-system-header-dir=/tools/include \
		--enable-languages=c,c++                       \
		--disable-libstdcxx-pch                        \
		--disable-multilib                             \
		--disable-bootstrap                            \
		--disable-libgomp

make
