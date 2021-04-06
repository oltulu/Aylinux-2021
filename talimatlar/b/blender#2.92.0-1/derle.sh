cd $SRC
cmake -S "${isim}"-"${surum}" -B build -G Ninja     \
        -D WITH_CYCLES=OFF                              \
        -D PYTHON_VERSION=3.9                           \
        -D WITH_CYCLES_EMBREE=OFF                       \
        -D WITH_INTERNATIONAL=OFF                       \
        -D WITH_PYTHON_INSTALL=OFF                      \
        -D PYTHON_LIBPATH=/usr/lib                      \
        -D CMAKE_BUILD_TYPE=Release                     \
        -D PYTHON_LIBRARY=python3.9                     \
        -D WITH_DOC_MANPAGE=ON                          \
        -D CMAKE_INSTALL_PREFIX=/usr                    \
        -D WITH_INSTALL_PORTABLE=OFF                    \
        -D OPTIX_ROOT_DIR="${SRC}"/include              \
        -D CMAKE_C_FLAGS_RELEASE="$CFLAGS -DNDEBUG"     \
        -D PYTHON_INCLUDE_DIRS=/usr/include/python3.9   \
        -D CMAKE_CXX_FLAGS_RELEASE="$CXXFLAGS -DNDEBUG"
