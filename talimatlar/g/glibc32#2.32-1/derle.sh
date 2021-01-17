# https://toolchains.bootlin.com/downloads/releases/toolchains/x86-i686/tarballs/x86-i686--glibc--stable-2020.08-1.tar.bz2
toolchain="x86-i686--glibc--stable-2020.08-1"
ln -sf $SRC/${toolchain} /opt/

export LC_ALL=C
export PATH=/opt/${toolchain}/bin:$PATH
mkdir -v build
cd build

CC="i686-buildroot-linux-gnu-gcc -m32" \
CXX="i686-buildroot-linux-gnu-g++ -m32" \
../configure --prefix=/usr \
--host=i686-pc-linux-gnu \
--build=$(../scripts/config.guess) \
--enable-multi-arch  \
--enable-kernel=3.2 \
--with-headers=/opt/${toolchain}/i686-buildroot-linux-gnu/sysroot/usr/include/ \
--libdir=/usr/lib32 \
--libexecdir=/usr/lib32 \
libc_cv_slibdir=/usr/lib32

make

