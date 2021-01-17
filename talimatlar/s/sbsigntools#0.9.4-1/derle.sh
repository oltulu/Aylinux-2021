cd ${isim}.git
patch -p1 -i ${SRC}/0001-sbsigntools-fix-autogen.sh-for-build-service.patch
git submodule init
git config submodule."lib/ccan.git".url ${SRC}/ccan
git submodule update
NOCONFIGURE=1 ./autogen.sh
./configure $confopt
cp lib/ccan.git/config.h lib/ccan/
sed -i 's/SUBDIRS = lib\/ccan src docs tests/SUBDIRS = lib\/ccan src/g' Makefile
make
