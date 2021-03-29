NEWPATH=$PKG/usr/lib/jvm/java-8-openjdk
mv $PKG/usr/lib/jvm/openjdk-1.8.0_282 ${NEWPATH}

rm -rf $PKG/usr/lib/bin

# izin
find ${NEWPATH} -iname '*.jar' -exec chmod ugo+r {} \;
chmod ugo+r ${NEWPATH}/lib/ct.sym

# Gereksiz dosyaların silinmesi
rm -f ${NEWPATH}/src.zip
rm -rf ${NEWPATH}/{demo,man/ja*,sample}
rm -f ${NEWPATH}/{,jre/}THIRD_PARTY_README
find ${NEWPATH} \( \
	-name '*.ja' -o \
	-name 'ASSEMBLY_EXCEPTION' -o \
	-name 'LICENSE' -o \
	-name 'THIRD_PARTY_README' \) \
	-delete

find  ${NEWPATH} -iname '*.diz' -exec rm {} \;
find  ${NEWPATH} -iname '*.debuginfo' -exec rm {} \;

# sertifika linklenmesi
rm ${NEWPATH}/jre/lib/security/cacerts
ln -sf /etc/ssl/certs/java/cacerts ${NEWPATH}/jre/lib/security/cacerts

# Aynı dosyaları linkle
rm ${NEWPATH}/jre/lib/amd64/libjawt.so
ln -sr ${NEWPATH}/lib/amd64/libjawt.so ${NEWPATH}/jre/lib/amd64/libjawt.so
rm ${NEWPATH}/jre/lib/amd64/jli/libjli.so
ln -sr ${NEWPATH}/lib/amd64/jli/libjli.so ${NEWPATH}/jre/lib/amd64/jli/libjli.so

for f in ${NEWPATH}/jre/bin/* ; do
	if [ -f ${NEWPATH}/bin/${f##*/} ]; then
		rm $f
		ln -sr ${NEWPATH}/bin/${f##*/} $f
	fi
done
