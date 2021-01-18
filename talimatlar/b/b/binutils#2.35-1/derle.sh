mkdir build
cd build
# hardened derleme yöntemleri içerdiği için mpsd derleme bayrakları pasife alındı
unset CFLAGS
CC=gcc        \
AR=-ar         \
RANLIB=ranlib \
sed -i '/^development=/s/true/false/' ../bfd/development.sh
sed -i "/ac_cpp=/s/\$CPPFLAGS/\$CPPFLAGS -O2/" ../libiberty/configure
../configure                   \
--prefix=/tools            	   \
--disable-nls                  \
--disable-werror               \
--with-lib-path=/tools/lib     \
--with-sysroot

make 
