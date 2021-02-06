ln -s ../isl-0.21 isl

  # Do not run fixincludes
  sed -i 's@\./fixinc\.sh@-c true@' gcc/Makefile.in

  # Arch Linux installs x86_64 libraries /lib
  sed -i '/m64=/s/lib64/lib/' gcc/config/i386/t-linux64

  # hack! - some configure tests for header files using "$CPP $CPPFLAGS"
  sed -i "/ac_cpp=/s/\$CPPFLAGS/\$CPPFLAGS -O2/" {libiberty,gcc}/configure

  # D hacks
  patch -p1 -i "/sources/gdc_phobos_path.patch"

  # Turn off SSP for nostdlib|nodefaultlibs|ffreestanding
  # https://bugs.archlinux.org/task/64270
  patch -p1 -i "/sources/fs64270.patch"

  # Fix a crash in mpv when mesa 20.2 is compiled with LTO
  # https://gitlab.freedesktop.org/mesa/mesa/-/issues/3239
  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96482
  patch -Np1 -i /sources/ipa-fix-bit-CPP-when-combined-with-IPA-bit-CP.patch
  patch -Np1 -i /sources/ipa-fix-ICE-in-get_default_value.patch

  mkdir -p "$SRC/gcc-build"
 cd $SRC/gcc-build

  # using -pipe causes spurious test-suite failures
  # http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48565
  CFLAGS=${CFLAGS/-pipe/}
  CXXFLAGS=${CXXFLAGS/-pipe/}

  "$SRC/gcc-$surum/configure" --prefix=/usr \
      --libdir=/usr/lib \
      --libexecdir=/usr/lib \
      --mandir=/usr/share/man \
      --infodir=/usr/share/info \
      --enable-languages=c,c++,ada,fortran,go,lto,objc,obj-c++,d \
      --with-isl \
      --with-linker-hash-style=gnu \
      --with-system-zlib \
      --enable-__cxa_atexit \
      --enable-cet=auto \
      --enable-checking=release \
      --enable-clocale=gnu \
      --enable-default-pie \
      --enable-default-ssp \
      --enable-gnu-indirect-function \
      --enable-gnu-unique-object \
      --enable-install-libiberty \
      --enable-linker-build-id \
      --enable-lto \
      --enable-multilib \
      --enable-plugin \
      --enable-shared \
      --enable-threads=posix \
      --disable-libssp \
      --disable-libstdcxx-pch \
      --disable-libunwind-exceptions \
      --disable-werror \
      gdc_include_dir=/usr/include/dlang/gdc

  make

