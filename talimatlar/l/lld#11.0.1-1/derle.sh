mkdir build
patch -Np2 -i ../respect-versioned-undefined-symbols.patch
cd build
cmake .. -G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=/usr \
-DPYTHON_EXECUTABLE=/usr/bin/python \
-DBUILD_SHARED_LIBS=ON \
-DLLVM_LINK_LLVM_DYLIB=ON \
-DLLVM_INCLUDE_TESTS=ON \
-DLLVM_BUILD_TESTS=OFF \
-DLLVM_BUILD_DOCS=OFF \
-DLLVM_ENABLE_SPHINX=OFF \
-DLLVM_MAIN_SRC_DIR="${SRC}/llvm-${surum}.src"
ninja
