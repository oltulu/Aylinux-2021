_java_ver=8
_jdk_update=222
_jdk_build=05
_repo_ver=jdk${_java_ver}u${_jdk_update}-b${_jdk_build}
_jdkname=openjdk8
_jvmdir=/usr/lib/jvm/java-8-openjdk
_prefix="jdk8u-${_repo_ver}/image"
_imgdir="${_prefix}/jvm/openjdk-1.8.0_$(printf '%.2d' ${_jdk_update})"

cd $SRC/${_imgdir}

# http://icedtea.classpath.org/bugzilla/show_bug.cgi?id=1437
find . -iname '*.jar' -exec chmod ugo+r {} \;
chmod ugo+r lib/ct.sym

# remove redundant *diz and *debuginfo files
find . -iname '*.diz' -exec rm {} \;
find . -iname '*.debuginfo' -exec rm {} \;

# Main files
install -d -m 755 "${PKG}${_jvmdir}"
install -d -m 755 "${PKG}${_jvmdir}/jre"

cp -a include lib "${PKG}${_jvmdir}"
cp -a jre/bin jre/lib "${PKG}${_jvmdir}/jre"

# 'bin' files
pushd bin

# 'java-rmi.cgi' will be handled separately as it should not be in the PATH and has no man page
for b in $(ls | grep -v java-rmi.cgi); do
if [ -e ../jre/bin/${b} ]; then
  # Provide a link of the jre binary in the jdk/bin/ directory
  ln -s ../jre/bin/${b} "${PKG}${_jvmdir}/bin/${b}"
else
  # Copy binary to jdk/bin/
  install -D -m 755 ${b} "${PKG}${_jvmdir}/bin/${b}"
fi
done
popd

# Handling 'java-rmi.cgi' separately
install -D -m 755 bin/java-rmi.cgi "${PKG}${_jvmdir}/bin/java-rmi.cgi"

# Set config files
mv "${PKG}${_jvmdir}"/jre/lib/management/jmxremote.password{.template,}
mv "${PKG}${_jvmdir}"/jre/lib/management/snmp.acl{.template,}

# Link JKS keystore from ca-certificates-utils
rm -f "${PKG}${_jvmdir}/jre/lib/security/cacerts"
ln -sf /etc/ssl/certs/java/cacerts "${PKG}${_jvmdir}/jre/lib/security/cacerts"
