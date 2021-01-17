install -m 644 -p $SRC/sddm.conf $PKG/etc/
sed -i 's|exec $@|exec $STARTUP $@|g' \
		$PKG/usr/share/sddm/scripts/Xsession
sed -i -e "\$asetxkbmap tr,us,ru" $PKG/usr/share/sddm/scripts/Xsetup
		
cat > $PKG/etc/pam.d/sddm << "EOF"
# Begin /etc/pam.d/sddm

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 0 quiet
#auth    sufficient     pam_succeed_if.so user ingroup nopasswdlogin
auth     include        system-auth

account  include        system-account
password include        system-password

session  required       pam_limits.so
session  include        system-session

# End /etc/pam.d/sddm
EOF

cat > $PKG/etc/pam.d/sddm-autologin << "EOF"
# Begin /etc/pam.d/sddm-autologin

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 0 quiet
#auth    sufficient     pam_succeed_if.so user ingroup nopasswdlogin
auth     required       pam_permit.so

account  include        system-account

password required       pam_deny.so

session  required       pam_limits.so
session  include        system-session

# End /etc/pam.d/sddm-autologin
EOF

cat > $PKG/etc/pam.d/sddm-greeter << "EOF"
# Begin /etc/pam.d/sddm-greeter

auth     required       pam_env.so
auth     required       pam_permit.so

account  required       pam_permit.so
password required       pam_deny.so
session  required       pam_unix.so
-session optional       pam_systemd.so

# End /etc/pam.d/sddm-greeter
EOF

