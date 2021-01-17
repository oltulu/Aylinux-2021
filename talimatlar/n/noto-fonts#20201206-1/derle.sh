cd $SRC/noto-fonts
  install -Dm644 $SRC/noto-fonts/Noto*.tt[fc] -t "$PKG"/usr/share/fonts/noto
  install -Dm644 $SRC/noto-fonts/Noto*.tt[fc] -t "$PKG"/usr/share/fonts/noto

  # Install fontconfig files
  install -Dm644 "$SRC"/noto-fonts/*.conf -t "$PKG"/etc/fonts/conf.avail/

  mkdir -p "$PKG"/usr/share/fonts/noto
  cp $SRC/noto-fonts/Noto*{Condensed,SemiBold,Extra}*.tt[fc] "$PKG"/usr/share/fonts/noto
