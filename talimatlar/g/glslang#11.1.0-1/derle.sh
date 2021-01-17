mkdir -p build-{shared,static}
(cd build-shared
cmake .. \
  -GNinja \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=ON
ninja
)
(cd build-static
cmake .. \
  -GNinja \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_BUILD_TYPE=Release \
  -DBUILD_SHARED_LIBS=OFF
ninja
)
