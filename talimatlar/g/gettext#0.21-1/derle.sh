cd gettext-tools
EMACS="no" ./configure --prefix=/usr --disable-shared
make -C gnulib-lib
make -C intl pluralx.c
make -C src msgfmt
make -C src msgmerge
make -C src xgettext
