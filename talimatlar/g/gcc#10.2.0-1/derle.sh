cd $SRC
patch -d $isim-$surum -p1 -i $SRC/$isim-nocheck-fixincludes.patch
    patch -d $isim-$surum -p1 -i $SRC/$isim-4.7.3-multilib-dirs.patch
mkdir build
    cd build
    ../$isim-$surum/configure --prefix=/usr \
                                --libexecdir=/usr/lib \
                                --enable-languages=c,c++,objc \
                                --enable-threads=posix \
                                --enable-__cxa_atexit \
                                --enable-clocale=gnu \
                                --enable-shared \
                                --disable-nls \
                                --with-x=no \
                                --with-system-zlib \
                                --enable-multilib \
				--enable-default-pie \
				--enable-default-ssp \
                                --with-pkgversion="aylinux"
				 make bootstrap
   
   make -j1 DESTDIR=$PKG install

    install -d $PKG/lib
    ln -sf ../usr/bin/cpp $PKG/lib/cpp
    ln -sf gcc $PKG/usr/bin/cc
    ln -sf g++ $PKG/usr/bin/c++

    mv $PKG/usr/lib/gcc/*/$surum/include-fixed/{limits.h,syslimits.h} $PKG/usr/lib/gcc/*/$surum/include/
    rm -r $PKG/usr/share/{info,$isim-$surum} 
    rm -r $PKG/usr/bin/*-linux-gnu-*
    rm -r $PKG/usr/lib/gcc/*/$surum/{install-tools,include-fixed} 

    for D in lib{,32}; do
        install -d -m 0755 $PKG/usr/share/gdb/auto-load/usr/${D}
        mv $PKG/usr/${D}/libstdc++.so.*-gdb.py $PKG/usr/share/gdb/auto-load/usr/${D}
    done

   # sed -i "s|-L$SRC[^ ]* ||g" $PKG/usr/lib{,32}/{libstdc++.la,libsupc++.la}
				
