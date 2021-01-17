make DESTDIR="$PKG" install

sed -e 's|\<user\s\+\w\+;|user html;|g' \
-e '44s|html|/usr/share/nginx/html|' \
-e '54s|html|/usr/share/nginx/html|' \
-i "$PKG"/etc/nginx/nginx.conf

rm "$PKG"/etc/nginx/*.default

install -d "$PKG"/var/lib/nginx
install -dm700 "$PKG"/var/lib/nginx/proxy

chmod 755 "$PKG"/var/log/nginx
chown root:root "$PKG"/var/log/nginx

install -d "$PKG"/usr/share/nginx
mv "$PKG"/etc/nginx/html/ "$PKG"/usr/share/nginx

install -Dm644 ../nginx-logrotate "$PKG"/etc/logrotate.d/nginx

rmdir "$PKG"/run

install -d "$PKG"/usr/share/man/man8/
gzip -9c man/nginx.8 > "$PKG"/usr/share/man/man8/nginx.8.gz

for i in ftdetect indent syntax; do
	install -Dm644 contrib/vim/$i/nginx.vim \
	"$PKG/usr/share/vim/vimfiles/$i/nginx.vim"
done
