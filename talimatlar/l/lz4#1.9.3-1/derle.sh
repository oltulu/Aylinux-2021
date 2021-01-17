make -C lib PREFIX=/usr
make -C programs PREFIX=/usr lz4 lz4c
rm -f passwd.lz4
programs/lz4 /etc/passwd passwd.lz4
programs/lz4 -d passwd.lz4 passwd
diff -q /etc/passwd passwd
rm passwd
