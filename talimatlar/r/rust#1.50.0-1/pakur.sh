#cd "rustc-$surum-src"

  cp -a dest-rust/* "$PKG"
  # delete unnecesary files, e.g. components and manifest files only used for the uninstall script
  cd "$PKG"/usr/lib/rustlib
  rm components install.log manifest-* rust-installer-version uninstall.sh

  # rustbuild always installs copies of the shared libraries to /usr/lib,
  # overwrite them with symlinks to the per-architecture versions
  ln -srft "$PKG"/usr/lib x86_64-unknown-linux-gnu/lib/*.so

  install -d "$PKG"/usr/share/bash-completion/
  mv "$PKG"/etc/bash_completion.d "$PKG"/usr/share/bash-completion/completions
 
  install -d "$PKG"/usr/lib/rustlib/ "$PKG"/usr/lib32/
  cp -a dest-i686 "$PKG"/usr/lib/rustlib/i686-unknown-linux-gnu
  ln -srft "$PKG"/usr/lib32 "$PKG"/usr/lib/rustlib/i686-unknown-linux-gnu/lib/*.so
  install -d "$PKG"/usr/lib/rustlib/
  cp -a dest-musl "$PKG"/usr/lib/rustlib/x86_64-unknown-linux-musl
