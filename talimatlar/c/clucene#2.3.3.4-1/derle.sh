cd "${SRC}"/${isim}-core-${surum}

# add missing contrib-libs needed by LibO 3.6, patch by FC
patch -Np1 -i "${SRC}"/clucene-core-$surum-install_contribs_lib.patch
# pkgconfig file is missing clucene-shared (upstream ID: 3461512), patch by FC
patch -Np1 -i "${SRC}"/clucene-core-$surum-pkgconfig.patch
# one upstream postrelease commit for proper zlib detection
patch -Np1 -i "${SRC}"/fix_zlib_detections.diff
# LibreOffice patches http://cgit.freedesktop.org/libreoffice/core/tree/clucene/patches
patch -Np0 -i "${SRC}"/clucene-warnings.patch
patch -Np0 -i "${SRC}"/clucene-gcc-atomics.patch
patch -Np0 -i "${SRC}"/clucene-debug.patch
patch -Np0 -i "${SRC}"/clucene-narrowing-conversions.patch
patch -Np0 -i "${SRC}"/clucene-multimap-put.patch

mkdir build
pushd build
cmake .. \
-DCMAKE_INSTALL_PREFIX=/usr \
-DENABLE_ASCII_MODE=OFF -DENABLE_PACKAGING=OFF \
-DBUILD_CONTRIBS_LIB:BOOL=ON -DLIB_DESTINATION:PATH=/usr/lib \
-DLUCENE_SYS_INCLUDES:PATH=/usr/include -DDISABLE_MULTITHREADING=OFF
popd
make -C build
