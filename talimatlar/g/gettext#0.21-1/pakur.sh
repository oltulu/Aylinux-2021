cd gettext-tools	
mkdir -p $PKG/usr/bin
cp -v src/{msgfmt,msgmerge,xgettext} $PKG/usr/bin
