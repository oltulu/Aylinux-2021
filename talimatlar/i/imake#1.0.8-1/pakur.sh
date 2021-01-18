cd $SRC 
for i in *; do
if [ -d "${i}" ]; then
  pushd "${i}"
  make DESTDIR="${PKG}" install
  popd
fi
done
