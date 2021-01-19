export KCONFIG_NOTIMESTAMP=1
cd $SRC
MUSL_VERS="1.2.0"

BUILDROOT=$SRC
mkdir -p $BUILDROOT

# kernel header path
KHDR_BASE=/usr

# build first musl-c

cd $BUILDROOT/musl-$MUSL_VERS
./configure --prefix=$BUILDROOT/_work/musl-$MUSL_VERS --disable-shared
make -j2 && make install

PATH=$BUILDROOT/_work/musl-$MUSL_VERS/bin:$PATH

# use binutils and linux-headers from the buildhost
mkdir -p $BUILDROOT/_work/musl-$MUSL_VERS/bin
cd $BUILDROOT/_work/musl-$MUSL_VERS/bin
ln -s `which ar` musl-ar
ln -s `which strip` musl-strip
cd $BUILDROOT/_work/musl-$MUSL_VERS/include

ln -s $KHDR_BASE/include/linux linux
ln -s $KHDR_BASE/include/mtd mtd
if [ -d $KHDR_BASE/include/asm ]
then
  ln -s $KHDR_BASE/include/asm asm
else
  ln -s $KHDR_BASE/include/asm-generic asm
fi
ln -s $KHDR_BASE/include/asm-generic asm-generic

# build busybox

cd $BUILDROOT/busybox-$surum
cp $SRC/busybox-$surum-$devir.config .config

make CC=musl-gcc

#source: https://gist.github.com/bensallen/764b94ad702bc144ca04d861f50cbeef
