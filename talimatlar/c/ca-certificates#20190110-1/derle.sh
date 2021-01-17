gcc $CFLAGS ${SRC}/certdata2pem.c -o mozilla/certdata2pem
cp ${SRC}/remove-expired-certs.sh mozilla
sed -i mozilla/Makefile -e 's,python certdata2pem.py,./certdata2pem,g'
sed -i mozilla/Makefile -e "s;\(.*\)\(certdata2pem.*\);\1\2\n\1./remove-expired-certs.sh;"
make ${MAKEJOBS}
