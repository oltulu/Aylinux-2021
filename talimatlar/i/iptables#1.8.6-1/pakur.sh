make DESTDIR=$PKG install
	
cd ${SRC}
install -Dm644 empty.rules "$PKG/etc/iptables/iptables.rules"
install -Dm644 empty.rules "$PKG/etc/iptables/ip6tables.rules"
install -Dt "$PKG/usr/share/iptables" -m644 *.rules
ln -srt "$PKG/etc/iptables" "$PKG"/usr/share/iptables/{empty,simple_firewall}.rules
