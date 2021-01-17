./configure --prefix=/usr \
--enable-shared
make

# minilzo derlemesi
gcc $CPPFLAGS $CFLAGS -fpic -Iinclude/lzo -o minilzo/minilzo.o -c minilzo/minilzo.c
gcc $LDFLAGS -shared -o libminilzo.so.0 -Wl,-soname,libminilzo.so.0 minilzo/minilzo.o
