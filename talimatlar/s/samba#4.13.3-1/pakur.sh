 # man pages
    local p
    for p in docs/manpages/*; do 
        install -D -m 644 $p $PKG/usr/share/man/man${p##*.}/${p##*/}
    done

    # cleanup
    chmod 1777 $PKG/var/lock

    # config-file and start-script
    install -d $PKG/etc/{samba,rc.d}
    install -m 0600 examples/smb.conf.default $PKG/etc/samba
    install -m 0755 $SRC/samba $PKG/etc/rc.d

    # revdep
    install -d $PKG/etc/revdep.d
    echo '/usr/lib/samba' > $PKG/etc/revdep.d/samba
