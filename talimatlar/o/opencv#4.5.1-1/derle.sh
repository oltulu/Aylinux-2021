mkdir -p build
patch -p1 -i ../opencv-includedir.patch # Fix wrong include patch in pkgconfig file
sed -e '/ocv_tbb_cmake_guess(HAVE_TBB)/d' -i cmake/OpenCVDetectTBB.cmake # Don't use TBB's cmake config, it breaks build

cd build

export _pythonpath=`python -c "from sysconfig import get_path; print(get_path('platlib'))"`

export OpenJPEG_DIR=/usr/lib/openjpeg-2.3

cmake ../ \
	-DWITH_OPENCL=ON \
	-DWITH_OPENGL=ON \
	-DWITH_TBB=ON \
	-DWITH_VULKAN=ON \
	-DWITH_QT=OFF \
	-DBUILD_WITH_DEBUG_INFO=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DBUILD_EXAMPLES=OFF \
	-DINSTALL_C_EXAMPLES=OFF \
	-DINSTALL_PYTHON_EXAMPLES=OFF \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DCPU_BASELINE_DISABLE=SSE3 \
	-DCPU_BASELINE_REQUIRE=SSE2 \
	-DOPENCV_EXTRA_MODULES_PATH="$SRC/opencv_contrib-$surum/modules" \
	-DOPENCV_SKIP_PYTHON_LOADER=ON \
	-DOPENCV_PYTHON3_INSTALL_PATH=${_pythonpath} \
	-DLAPACK_LIBRARIES="/usr/lib/liblapack.so;/usr/lib/libblas.so;/usr/lib/libcblas.so" \
	-DLAPACK_CBLAS_H="/usr/include/cblas.h" \
	-DLAPACK_LAPACKE_H="/usr/include/lapacke.h" \
	-DOPENCV_GENERATE_PKGCONFIG=ON \
	-DOPENCV_ENABLE_NONFREE=ON \
	-DOPENCV_JNI_INSTALL_PATH=lib \
	-DOPENCV_GENERATE_SETUPVARS=OFF \
	-DEIGEN_INCLUDE_PATH=/usr/include/eigen3
make
