 cd "${SRC}"/nemo-extensions-${surum}/nemo-fileroller}
    make DESTDIR="${PKG}" install
 cd "${SRC}"/nemo-extensions-${surum}/nemo-image-converter
    make DESTDIR="${PKG}" install
 cd "${SRC}"/nemo-extensions-${surum}/nemo-preview/builddir
    DESTDIR="${PKG}" samu install
 cd "${SRC}"/nemo-extensions-${surum}/nemo-python/builddir
    DESTDIR="${PKG}" samu install
 cd "${SRC}"/nemo-extensions-${surum}/nemo-share
    make DESTDIR="${PKG}" install
 cd "${SRC}"/nemo-extensions-${surum}/nemo-terminal
    install -Dm644 src/nemo_terminal.py "${PKG}"/usr/share/nemo-python/extensions/nemo_terminal.py
    install -Dm755 src/nemo-terminal-prefs.py "${PKG}"/usr/bin/nemo-terminal-prefs
    install -Dm644 src/org.nemo.extensions.nemo-terminal.gschema.xml "${PKG}"/usr/share/glib-2.0/schemas/org.nemo.extensions.nemo-terminal.gschema.xml
    install -Dm644 pixmap/logo_120x120.png "${PKG}"/usr/share/nemo-terminal/logo_120x120.png