  cd "$SRC"/shaderc/third_party/

  if [ ! -d googletest ]; then
    git clone https://github.com/google/googletest googletest
  fi

  if [ ! -d glslang ]; then
    git clone https://github.com/google/glslang glslang
  fi

  if [ ! -d spirv-tools ]; then
    git clone https://github.com/KhronosGroup/SPIRV-Tools spirv-tools
  fi

  if [ ! -d spirv-tools/external/spirv-headers ]; then
    git clone https://github.com/KhronosGroup/SPIRV-Headers spirv-tools/external/spirv-headers
  fi
  
  cd "$SRC"

  mkdir -p build
  cd build

  cmake "$SRC"/shaderc \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DSHADERC_SKIP_TESTS=on \
    -GNinja \
    -Dshaderc_SOURCE_DIR="$SRC"/shaderc \
    -DPYTHON_EXE=/usr/bin/python2
  ninja glslc
  
