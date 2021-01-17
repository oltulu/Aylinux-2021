mkdir build
mv "$SRC/clang-tools-extra-$surum.src" tools/extra
patch -Np2 -i ../enable-SSP-and-PIE-by-default.patch

if [[ $surum != 10.* ]]; then
	echo "Remove libclangHandleLLVM hack!"
	return 1
fi
# Remove libclangHandleLLVM; breaks zig (https://reviews.llvm.org/D75579)
sed -i '/add_clang_subdirectory(handle-llvm)/d' tools/clang-fuzzer/CMakeLists.txt

cd build 
cmake .. -G Ninja \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/usr \
	-DPYTHON_EXECUTABLE=/usr/bin/python \
	-DLLVM_CONFIG:FILEPATH=/usr/bin/llvm-config \
	-DLLVM_LINK_LLVM_DYLIB=ON \
	-DCLANG_LINK_CLANG_DYLIB=ON \
	-DLLVM_ENABLE_RTTI=ON \
	-DLLVM_BUILD_TESTS=OFF \
	-DLLVM_INCLUDE_DOCS=OFF \
	-DLLVM_BUILD_DOCS=OFF \
	-DCLANG_BUILD_EXAMPLES:BOOL=OFF \
	-DLLVM_ENABLE_SPHINX:BOOL=OFF \
	-DCLANG_INCLUDE_TESTS:BOOL=OFF \
	-DSPHINX_WARNINGS_AS_ERRORS=OFF \
	-DLLVM_EXTERNAL_LIT=/usr/bin/lit \
	-DLLVM_MAIN_SRC_DIR="$SRC/llvm-$surum.src"
ninja
