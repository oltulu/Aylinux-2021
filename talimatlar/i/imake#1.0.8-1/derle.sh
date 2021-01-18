cd $SRC/xorg-cf-files-1.0.6
patch -p1 -i ../imake-linuxconfig.patch

cd $SRC 

for i in *; do
if [ -d "${i}" ]; then
  pushd "${i}"
  autoreconf -fi
  ./configure --prefix=/usr --mandir=/usr/share/man
  make
  popd
fi
done
