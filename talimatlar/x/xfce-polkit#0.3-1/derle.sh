aclocal
	autoconf
	automake \
		--add-missing \
		--foreign

	./configure \
	  --prefix=/usr \
	  --libexecdir=/usr/lib/$isim \
	  --sysconfdir=/etc

	make
