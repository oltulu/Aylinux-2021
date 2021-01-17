find -name "Makefile.linux" -exec sed -i "{}" \
	-e "s;CFLAGS\\s*=\(.*\);CFLAGS = ${CFLAGS} \1;" \;
# Custom LDFLAGS for chat, pppoe-discovery and pppdump
sed -i chat/Makefile.linux \
	-e "s;-o chat ;${LDFLAGS} -o chat ;"
sed -i pppd/plugins/rp-pppoe/Makefile.linux \
	-e "s;-o pppoe-discovery ;${LDFLAGS} -o pppoe-discovery ;"
sed -i pppdump/Makefile.linux \
	-e "s;-o pppdump ;${LDFLAGS} -o pppdump ;"
# Enable active filter
sed -i "s:^#FILTER=y:FILTER=y:" pppd/Makefile.linux
# Enable ipv6 support
sed -i "s:^#HAVE_INET6=y:HAVE_INET6=y:" pppd/Makefile.linux
# Enable Microsoft Proprietary Callback Control Protocol
sed -i "s:^#CBCP=y:CBCP=y:" pppd/Makefile.linux

./configure ${confopt}

make COPTS="${CFLAGS} -D_GNU_SOURCE ${LDFLAGS}" ${MAKEJOBS}
