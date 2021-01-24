_majorver=${surum%.*}
make \
TO_LIB="liblua.a liblua.so liblua.so.$_majorver liblua.so.$surum" \
INSTALL_DATA='cp -d' \
INSTALL_TOP="$PKG"/usr \
install
