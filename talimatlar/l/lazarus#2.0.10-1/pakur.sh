mkdir -p $PKG/usr/lib/lazarus
mkdir -p $PKG/usr/bin
mkdir -p $PKG/usr/share/man/man1
mkdir -p $PKG/usr/share/applications
mkdir -p $PKG/usr/share/pixmaps

rsync -a \
--exclude="CVS"     --exclude=".cvsignore" \
--exclude="*.ppw"   --exclude="*.ppl" \
--exclude="*.ow"    --exclude="*.a"\
--exclude="*.rst"   --exclude=".#*" \
--exclude="*.~*"    --exclude="*.bak" \
--exclude="*.orig"  --exclude="*.rej" \
--exclude=".xvpics" \
--exclude="killme*" --exclude=".gdb_hist*" \
--exclude="debian"  --exclude="COPYING*" \
--exclude="*.app"   --exclude="tools/install" \
. "${PKG}"/usr/lib/lazarus

ln -rs ${PKG}/usr/lib/lazarus/lazbuild ${PKG}/usr/bin/lazbuild

cp -R install/man/man1/* ${PKG}/usr/share/man/man1

rm -rf ${PKG}/usr/lib/lazarus/docs

rm -rf ${PKG}/usr/lib/lazarus/{install,test}

# Symlink binaries from usr/lib/lazarus to usr/bin
ln -rs ${PKG}/usr/lib/lazarus/lazarus ${PKG}/usr/bin/lazarus
ln -rs ${PKG}/usr/lib/lazarus/startlazarus ${PKG}/usr/bin/startlazarus

# make 'desktop-file-validate' happy and fix missing .png icon
sed -e 's|\(Categories\).*|\1=IDE;Development;|' -i install/lazarus.desktop
install -m644 install/lazarus.desktop $PKG/usr/share/applications/lazarus.desktop
install -m644 images/ide_icon48x48.png $PKG/usr/share/pixmaps/lazarus.png

