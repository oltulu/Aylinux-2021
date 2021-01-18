export py_version="3.7"
mkdir build
cd build
cmake \
-C../build_files/cmake/config/blender_release.cmake .. \
-DCMAKE_INSTALL_PREFIX=/usr \
-DCMAKE_BUILD_TYPE=Release \
-DWITH_INSTALL_PORTABLE=OFF \
-DWITH_PYTHON_INSTALL=OFF \
-DWITH_JACK=ON \
-DWITH_CODEC_FFMPEG=ON \
-DWITH_CODEC_SNDFILE=ON \
-DWITH_OPENMP=ON \
-DWITH_FFTW3=ON \
-DWITH_MOD_OCEANSIM=ON \
-DWITH_CYCLES=ON \
-DWITH_OPENCOLORIO=ON \
-DWITH_IMAGE_OPENEXR=ON \
-DWITH_IMAGE_OPENJPEG=ON \
-DWITH_OPENSUBDIV=ON \
-DWITH_OPENCOLLADA=ON \
-DWITH_SYSTEM_GLEW=ON \
-DWITH_OPENVDB=ON \
-DWITH_BUILDINFO=OFF \
-DSTOP_ON_WARNING=0 \
-DPYTHON_VERSION=${py_version} \
-DPYTHON_LIBPATH=/usr/lib \
-DPYTHON_LIBRARY=python${py_version}m \
-DPYTHON_INCLUDE_DIRS="/usr/include/python${py_version}m" || make $MAKEJOBS


