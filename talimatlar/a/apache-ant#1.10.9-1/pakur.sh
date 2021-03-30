cd apache-ant-$surum
_ant_home=/usr/share/apache-ant

install -d "${PKG}${_ant_home}"
cp -Rp etc "${PKG}${_ant_home}"

find bin -type f -a ! -name \*.bat -a ! -name \*.cmd \
-exec install -Dm 755 {} -t "${PKG}${_ant_home}/bin" \;
install -d "${PKG}/usr/bin"
ln -s ${_ant_home}/bin/ant "${PKG}/usr/bin/ant"

install -Dm 644 "${SRC}/ant.conf" -t "${PKG}/etc"
install -Dm 644 lib/*.jar -t "${PKG}/usr/share/java/ant"
ln -s /usr/share/java/ant "${PKG}${_ant_home}/lib"

mkdir -p ${PKG}/etc/profile.d
install -Dm 644 $SRC/apache-ant.sh -t ${PKG}/etc/profile.d
