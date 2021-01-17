cd $SRC/google-droid-fonts-$surum
        install -d $PKG/usr/share/fonts/TTF/ 
        install -m644 *.ttf $PKG/usr/share/fonts/TTF/ 

        # Install fontconfig
        cd $SRC
        install -d $PKG/etc/fonts/conf.avail/
        install -m644 sans-fontconfig.conf $PKG/etc/fonts/conf.avail/65-$isim-sans-fontconfig.conf
        install -m644 sans-mono-fontconfig.conf $PKG/etc/fonts/conf.avail/60-$isim-sans-mono-fontconfig.conf
        install -m644 serif-fontconfig.conf $PKG/etc/fonts/conf.avail/65-$isim-serif-fontconfig.conf
        install -m644 kufi-fontconfig.conf $PKG/etc/fonts/conf.avail/65-$isim-kufi-fontconfig.conf