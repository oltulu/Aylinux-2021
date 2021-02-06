_libdir=usr/lib/gcc/$CHOST/${surum%%+*}
_majorver=${surum%%.*}
cd gcc-build
  make -C $CHOST/libgcc DESTDIR="$PKG" install-shared
  rm -f "$PKG/$_libdir/libgcc_eh.a"

  for lib in libatomic \
             libgfortran \
             libgo \
             libgomp \
             libitm \
             libquadmath \
             libsanitizer/{a,l,ub,t}san \
             libstdc++-v3/src \
             libvtv; do
    make -C $CHOST/$lib DESTDIR="$PKG" install-toolexeclibLTLIBRARIES
  done

  make -C $CHOST/libobjc DESTDIR="$PKG" install-libs
  make -C $CHOST/libstdc++-v3/po DESTDIR="$PKG" install

  make -C $CHOST/libphobos DESTDIR="$PKG" install
  rm -rf "$PKG"/$_libdir/include/d/
  rm -f "$PKG"/usr/lib/libgphobos.spec

  for lib in libgomp \
             libitm \
             libquadmath; do
    make -C $CHOST/$lib DESTDIR="$PKG" install-info
  done

  # remove files provided by lib32-gcc-libs
  rm -rf "$PKG"/usr/lib32/


  make -C gcc DESTDIR="$PKG" install-driver install-cpp install-gcc-ar \
    c++.install-common install-headers install-plugin install-lto-wrapper

  install -m755 -t "$PKG/usr/bin/" gcc/gcov{,-tool}
  install -m755 -t "$PKG/${_libdir}/" gcc/{cc1,cc1plus,collect2,lto1}

  make -C $CHOST/libgcc DESTDIR="$PKG" install
  make -C $CHOST/32/libgcc DESTDIR="$PKG" install
  rm -f "$PKG"/usr/lib{,32}/libgcc_s.so*

  make -C $CHOST/libstdc++-v3/src DESTDIR="$PKG" install
  make -C $CHOST/libstdc++-v3/include DESTDIR="$PKG" install
  make -C $CHOST/libstdc++-v3/libsupc++ DESTDIR="$PKG" install
  make -C $CHOST/libstdc++-v3/python DESTDIR="$PKG" install
  make -C $CHOST/32/libstdc++-v3/src DESTDIR="$PKG" install
  make -C $CHOST/32/libstdc++-v3/include DESTDIR="$PKG" install
  make -C $CHOST/32/libstdc++-v3/libsupc++ DESTDIR="$PKG" install

  make DESTDIR="$PKG" install-libcc1
  install -d "$PKG/usr/share/gdb/auto-load/usr/lib"
  mv "$PKG"/usr/lib/libstdc++.so.6.*-gdb.py \
    "$PKG/usr/share/gdb/auto-load/usr/lib/"
  rm "$PKG"/usr/lib{,32}/libstdc++.so*

  make DESTDIR="$PKG" install-fixincludes
  make -C gcc DESTDIR="$PKG" install-mkheaders

  make -C lto-plugin DESTDIR="$PKG" install
  install -dm755 "$PKG"/usr/lib/bfd-plugins/
  ln -s /${_libdir}/liblto_plugin.so \
    "$PKG/usr/lib/bfd-plugins/"

  make -C $CHOST/libgomp DESTDIR="$PKG" install-nodist_{libsubinclude,toolexeclib}HEADERS
  make -C $CHOST/libitm DESTDIR="$PKG" install-nodist_toolexeclibHEADERS
  make -C $CHOST/libquadmath DESTDIR="$PKG" install-nodist_libsubincludeHEADERS
  make -C $CHOST/libsanitizer DESTDIR="$PKG" install-nodist_{saninclude,toolexeclib}HEADERS
  make -C $CHOST/libsanitizer/asan DESTDIR="$PKG" install-nodist_toolexeclibHEADERS
  make -C $CHOST/libsanitizer/tsan DESTDIR="$PKG" install-nodist_toolexeclibHEADERS
  make -C $CHOST/libsanitizer/lsan DESTDIR="$PKG" install-nodist_toolexeclibHEADERS
  make -C $CHOST/32/libgomp DESTDIR="$PKG" install-nodist_toolexeclibHEADERS
  make -C $CHOST/32/libitm DESTDIR="$PKG" install-nodist_toolexeclibHEADERS
  make -C $CHOST/32/libsanitizer DESTDIR="$PKG" install-nodist_{saninclude,toolexeclib}HEADERS
  make -C $CHOST/32/libsanitizer/asan DESTDIR="$PKG" install-nodist_toolexeclibHEADERS

  make -C libiberty DESTDIR="$PKG" install
  install -m644 libiberty/pic/libiberty.a "$PKG/usr/lib"

  make -C gcc DESTDIR="$PKG" install-man install-info
  rm "$PKG"/usr/share/man/man1/{gccgo,gfortran,gdc}.1
  rm "$PKG"/usr/share/info/{gccgo,gfortran,gnat-style,gnat_rm,gnat_ugn,gdc}.info

  make -C libcpp DESTDIR="$PKG" install
  make -C gcc DESTDIR="$PKG" install-po

  # many packages expect this symlink
  ln -s gcc "$PKG"/usr/bin/cc

  # POSIX conformance launcher scripts for c89 and c99
  install -Dm755 "/sources/c89" "$PKG/usr/bin/c89"
  install -Dm755 "/sources/c99" "$PKG/usr/bin/c99"

  # install the libstdc++ man pages
  make -C $CHOST/libstdc++-v3/doc DESTDIR="$PKG" doc-install-man

  # remove files provided by lib32-gcc-libs
  rm -f "$PKG"/usr/lib32/lib{stdc++,gcc_s}.so

  # byte-compile python libraries
  python -m compileall "$PKG/usr/share/gcc-${surum%%+*}/"
  python -O -m compileall "$PKG/usr/share/gcc-${surum%%+*}/"


  make -C $CHOST/libgfortran DESTDIR="$PKG" install-cafexeclibLTLIBRARIES \
    install-{toolexeclibDATA,nodist_fincludeHEADERS,gfor_cHEADERS}
  make -C $CHOST/32/libgfortran DESTDIR="$PKG" install-cafexeclibLTLIBRARIES \
    install-{toolexeclibDATA,nodist_fincludeHEADERS,gfor_cHEADERS}
  make -C $CHOST/libgomp DESTDIR="$PKG" install-nodist_fincludeHEADERS
  make -C gcc DESTDIR="$PKG" fortran.install-{common,man,info}
  install -Dm755 gcc/f951 "$PKG/${_libdir}/f951"

  ln -s gfortran "$PKG/usr/bin/f95"

  make DESTDIR="$PKG" -C $CHOST/libobjc install-headers
  install -dm755 "$PKG/${_libdir}"
  install -m755 gcc/cc1obj{,plus} "$PKG/${_libdir}/"


  cd gcc
  make DESTDIR="$PKG" ada.install-{common,info}
  install -m755 gnat1 "$PKG/${_libdir}"

  cd "$SRC"/gcc-build/$CHOST/libada
  make DESTDIR="${PKG}" INSTALL="install" \
    INSTALL_DATA="install -m644" install-libada

  cd "$SRC"/gcc-build/$CHOST/32/libada
  make DESTDIR="${PKG}" INSTALL="install" \
    INSTALL_DATA="install -m644" install-libada

  ln -s gcc "$PKG/usr/bin/gnatgcc"

  # insist on dynamic linking, but keep static libraries because gnatmake complains
  mv "$PKG"/${_libdir}/adalib/libgna{rl,t}-${_majorver}.so "$PKG/usr/lib"
  ln -s libgnarl-${_majorver}.so "$PKG/usr/lib/libgnarl.so"
  ln -s libgnat-${_majorver}.so "$PKG/usr/lib/libgnat.so"
  rm -f "$PKG"/${_libdir}/adalib/libgna{rl,t}.so

  install -d "$PKG/usr/lib32/"
  mv "$PKG"/${_libdir}/32/adalib/libgna{rl,t}-${_majorver}.so "$PKG/usr/lib32"
  ln -s libgnarl-${_majorver}.so "$PKG/usr/lib32/libgnarl.so"
  ln -s libgnat-${_majorver}.so "$PKG/usr/lib32/libgnat.so"
  rm -f "$PKG"/${_libdir}/32/adalib/libgna{rl,t}.so

  make -C $CHOST/libgo DESTDIR="$PKG" install-exec-am
  make -C $CHOST/32/libgo DESTDIR="$PKG" install-exec-am
  make DESTDIR="$PKG" install-gotools
  make -C gcc DESTDIR="$PKG" go.install-{common,man,info}

  rm -f "$PKG"/usr/lib{,32}/libgo.so*
  install -Dm755 gcc/go1 "$PKG/${_libdir}/go1"


  make -C $CHOST/32/libgcc DESTDIR="$PKG" install-shared
  rm -f "$PKG/$_libdir/32/libgcc_eh.a"

  for lib in libatomic \
             libgfortran \
             libgo \
             libgomp \
             libitm \
             libquadmath \
             libsanitizer/{a,l,ub}san \
             libstdc++-v3/src \
             libvtv; do
    make -C $CHOST/32/$lib DESTDIR="$PKG" install-toolexeclibLTLIBRARIES
  done

  make -C $CHOST/32/libobjc DESTDIR="$PKG" install-libs

  make -C $CHOST/libphobos DESTDIR="$PKG" install
  rm -f "$PKG"/usr/lib32/libgphobos.spec

  make -C gcc DESTDIR="$PKG" d.install-{common,man,info}

  install -Dm755 gcc/gdc "$PKG"/usr/bin/gdc
  install -Dm755 gcc/d21 "$PKG"/"$_libdir"/d21

  make -C $CHOST/libphobos DESTDIR="$PKG" install
  rm -f "$PKG/usr/lib/"lib{gphobos,gdruntime}.so*
  rm -f "$PKG/usr/lib32/"lib{gphobos,gdruntime}.so*

  install -d "$pkgdir"/usr/include/dlang
  ln -s /"${_libdir}"/include/d "$PKG"/usr/include/dlang/gdc

 
