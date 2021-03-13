# keymapları kendi isimleriyle yeniden isimlendiriyoruz.
# loadkeys komutunda önce bulunan keymap yüklenme sorunu için
mv data/keymaps/i386/qwertz/cz{,-qwertz}.map
mv data/keymaps/i386/olpc/es{,-olpc}.map
mv data/keymaps/i386/olpc/pt{,-olpc}.map
mv data/keymaps/i386/fgGIod/trf{,-fgGIod}.map
mv data/keymaps/i386/colemak/{en-latin9,colemak}.map

patch -Np1 -i ../fix-euro2.patch
patch -Np1 -i /sources/kbd-2.4.0-backspace-1.patch
./configure --prefix=/usr --datadir=/usr/share/kbd --disable-vlock --disable-tests
make 

