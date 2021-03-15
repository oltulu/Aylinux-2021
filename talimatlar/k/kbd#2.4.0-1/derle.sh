# keymapları kendi isimleriyle yeniden isimlendiriyoruz.
# loadkeys komutunda önce bulunan keymap yüklenme sorunu için
mv data/keymaps/i386/qwertz/cz{,-qwertz}.map
mv data/keymaps/i386/olpc/es{,-olpc}.map
mv data/keymaps/i386/olpc/pt{,-olpc}.map
mv data/keymaps/i386/fgGIod/trf{,-fgGIod}.map
mv data/keymaps/i386/colemak/{en-latin9,colemak}.map

patch -Np1 -i $SRC/fix-euro2.patch
autoreconf -if
./configure --prefix=/usr --sysconfdir=/etc --datadir=/usr/share/kbd --mandir=/usr/share/man
make KEYCODES_PROGS=yes RESIZECONS_PROGS=yes
