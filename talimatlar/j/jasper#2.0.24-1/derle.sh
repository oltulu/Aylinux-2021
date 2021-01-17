cd $SRC/${isim}-version-${surum}
patch -p1 < "${SRC}/jasper-1.900.1-fix-filename-buffer-overflow.patch"
sed -r 's|(CMAKE_SKIP_BUILD_RPATH) FALSE|\1 TRUE|g' -i CMakeLists.txt
mkdir -p build
cd build
cmake \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCMAKE_INSTALL_LIBDIR=lib \
	-DCMAKE_BUILD_TYPE=Release \
	-DJAS_ENABLE_OPENGL=ON \
	-DJAS_ENABLE_LIBJPEG=ON \
	-DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=OFF \
	-DCMAKE_SKIP_RPATH=ON \
	-DJAS_ENABLE_SHARED=ON ..
make
