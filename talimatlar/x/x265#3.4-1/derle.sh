cd x265_3.4
  for d in 8 10 12; do
    if [[ -d build-$d ]]; then
      rm -rf build-$d
    fi
    mkdir build-$d
  done
  cd build-12

  cmake ../source \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DHIGH_BIT_DEPTH=TRUE \
    -DMAIN12=TRUE \
    -DEXPORT_C_API=FALSE \
    -DENABLE_CLI=FALSE \
    -DENABLE_SHARED=FALSE
  make

  cd ../build-10

  cmake ../source \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DHIGH_BIT_DEPTH=TRUE \
    -DEXPORT_C_API=FALSE \
    -DENABLE_CLI=FALSE \
    -DENABLE_SHARED=FALSE
  make

  cd ../build-8

  ln -s ../build-10/libx265.a libx265_main10.a
  ln -s ../build-12/libx265.a libx265_main12.a

  cmake ../source \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DENABLE_SHARED=TRUE \
    -DENABLE_HDR10_PLUS=TRUE \
    -DEXTRA_LIB='x265_main10.a;x265_main12.a' \
    -DEXTRA_LINK_FLAGS='-L .' \
    -DLINKED_10BIT=TRUE \
    -DLINKED_12BIT=TRUE
  make
