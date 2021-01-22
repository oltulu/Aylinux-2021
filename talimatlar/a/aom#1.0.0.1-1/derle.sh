patch -Np0 -i $SRC/libaom-version.patch
mkdir -p build
cd build
cmake -G Ninja ../ \
-DCMAKE_INSTALL_PREFIX=/usr \
-DBUILD_SHARED_LIBS=1 \
-DENABLE_TESTS=0
cmake --build .
