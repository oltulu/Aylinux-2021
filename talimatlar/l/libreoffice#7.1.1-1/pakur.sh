cd $SRC
mv fakeinstall/* ${PKG}/

# put configuration files into place
install -dm755 "${PKG}"/etc/libreoffice
install -m644 "${PKG}"/usr/lib/libreoffice/program/{bootstraprc,sofficerc} "${PKG}"/etc/libreoffice/
install -m644 "${PKG}"/usr/lib/libreoffice/share/psprint/psprint.conf "${PKG}"/etc/libreoffice/

# install dummy links to make them found by LibO
cd "${PKG}"/usr/lib/libreoffice/program/
ln -vsf /etc/libreoffice/{bootstraprc,sofficerc} .
cd "${PKG}"/usr/lib/libreoffice/share/psprint/
ln -vsf /etc/libreoffice/psprint.conf .

# allow to preset desired VLC
install -dm755 "${PKG}"/etc/profile.d

# make pyuno find its modules
install -dm755 "${PKG}"/usr/lib/python3.7/site-packages
ln -svf /usr/lib/libreoffice/program/uno.py "${PKG}"/usr/lib/python3.7/site-packages/uno.py
ln -svf /usr/lib/libreoffice/program/unohelper.py "${PKG}"/usr/lib/python3.7/site-packages/unohelper.py
	
# add a symlink required for gnome-documents; FS#51887
# https://lists.freedesktop.org/archives/libreoffice/2016-March/073787.html
ln -svf /usr/lib/libreoffice/program/liblibreofficekitgtk.so "${PKG}"/usr/lib/liblibreofficekitgtk.so  

# add application descriptions
install -dm755 "${PKG}"/usr/share/metainfo
install -v -m644 "${SRC}"/libreoffice-$surum/sysui/desktop/appstream-appdata/*.xml "${PKG}"/usr/share/metainfo
