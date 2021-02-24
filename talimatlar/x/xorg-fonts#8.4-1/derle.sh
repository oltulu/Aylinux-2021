unset MAKEFLAGS
cat > font-7.md5 << "EOF"
23756dab809f9ec5011bb27fb2c3c7d6  font-util-1.3.1.tar.bz2
0f2d6546d514c5cc4ecf78a60657a5c1  encodings-1.0.4.tar.bz2
6d25f64796fef34b53b439c2e9efa562  font-alias-1.0.3.tar.bz2
fcf24554c348df3c689b91596d7f9971  font-adobe-utopia-type1-1.0.4.tar.bz2
e8ca58ea0d3726b94fe9f2c17344be60  font-bh-ttf-1.0.3.tar.bz2
53ed9a42388b7ebb689bdfc374f96a22  font-bh-type1-1.0.3.tar.bz2
bfb2593d2102585f45daa960f43cb3c4  font-ibm-type1-1.0.3.tar.bz2
6306c808f7d7e7d660dfb3859f9091d2  font-misc-ethiopic-1.0.3.tar.bz2
3eeb3fb44690b477d510bbd8f86cf5aa  font-xfree86-type1-1.0.4.tar.bz2
EOF
for paket in $(grep -v '^#' font-7.md5 |cut -d " " -f 3)
	do
		cd $DERLEME_KAYNAKDIZIN/
		#agdan ceker
		if [ ! -f $DERLEME_KAYNAKDIZIN/$paket ];then
			wget https://www.x.org/archive//individual/font/$paket
		fi
		
		grep $paket $SRC/font-7.md5 |md5sum -c -
		paketdizini=$(echo $paket | sed 's/.tar.bz2//')
		cd -
		tar -xf $DERLEME_KAYNAKDIZIN/$paket 

		pushd $paketdizini
		case $paketdizini in
			luit-[0-9]* )
				line1="#ifdef _XOPEN_SOURCE"
				line2="#  undef _XOPEN_SOURCE"
				line3="#  define _XOPEN_SOURCE 600"
				line4="#endif"
				sed -i -e "s@#ifdef HAVE_CONFIG_H@$line1\n$line2\n$line3\n$line4\n\n&@" sys.c
				unset line1 line2 line3 line4
			;;
			sessreg-* )
				sed -e 's/\$(CPP) \$(DEFS)/$(CPP) -P $(DEFS)/' -i man/Makefile.in
			;;
		esac
		./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static
		make
		make DESTDIR=$PKG install
		popd
	done
