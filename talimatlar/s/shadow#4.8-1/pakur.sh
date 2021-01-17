make DESTDIR=$PKG install

    install -d $PKG/etc/cron/daily
    install -m 644 /sources/login.defs $PKG/etc
    install -m 755 /sources/pwck $PKG/etc/cron/daily


    rm -rf $PKG/usr/bin/gpasswd \
          $PKG/usr/man/man1/gpasswd.1 \
          $PKG/usr/sbin/{chpasswd,grpconv,grpunconv,logoutd} \
          $PKG/usr/sbin/{newusers,pwconv,pwunconv} \
          $PKG/usr/share/man/man8/{chpasswd.8,grpconv.8,grpunconv.8,logoutd.8} \
          $PKG/usr/share/man/man8/{newusers.8,pwconv.8,pwunconv.8} \
          $PKG/usr/share/man/man5/gshadow.5 \
          $PKG/usr/share/man/man3 \
          $PKG/etc/{login.access,limits,default}

    # Check if we built with PAM
    if [ -n "$(ldd $PKG/usr/bin/su |grep libpam)" ]; then
        find $PKG/etc/pam.d -type f -exec sed -i -e '/pam_selinux.so/d' {} +
        sed -i -r -e '/^(FAILLOG_ENAB|LASTLOG_ENAB|MAIL_CHECK_ENAB|OBSCURE_CHECKS_ENAB|QUOTAS_ENAB|MOTD_FILE|FTMP_FILE|NOLOGINS_FILE|ENV_HZ|PASS_MIN_LEN|SU_WHEEL_ONLY|PASS_CHANGE_TRIES|PASS_ALWAYS_WARN|CHFN_AUTH|PASS_MAX_LEN)/d' $PKG/etc/login.defs
    else
	mkdir -p $PKG/var/log
        touch $PKG/var/log/{lastlog,faillog}
    fi
