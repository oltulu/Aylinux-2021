/usr/milis/bin/update-ca-trust

_java_ver=8
_jdk_update=282
_jdk_build=08
_repo_ver=jdk${_java_ver}u${_jdk_update}-b${_jdk_build}
_jdkname=openjdk8
_jvmdir=/usr/lib/jvm/java-8-openjdk

for d in corba hotspot jaxp jaxws jdk langtools nashorn; do
	mv $d-jdk${_java_ver}u${_jdk_update}-b${_jdk_build} jdk8u-jdk${_java_ver}u${_jdk_update}-b${_jdk_build}/$d
done

cd jdk8u-jdk${_java_ver}u${_jdk_update}-b${_jdk_build}

OLD_PATH=$PATH
export JAVA_HOME=$SRC/${isim}-boot
export PATH=$JAVA_HOME/bin:$OLD_PATH

WARN_CFLAGS="-Wno-error=return-type -Wno-error=stringop-overflow= -Wno-error=deprecated-declarations"
EXTRA_CFLAGS="-fno-delete-null-pointer-checks -fno-lifetime-dse $WARN_CFLAGS"

unset CFLAGS
unset CXXFLAGS
export CFLAGS="$EXTRA_CFLAGS"
export CXXFLAGS="$EXTRA_CFLAGS"

[ -z $JOBS ] && JOBS=$(nproc)

LC_ALL=C \
/bin/bash configure $EXTRA_OPTIONS \
	--prefix=$PKG/usr/lib \
	--enable-unlimited-crypto \
	--with-boot-jdk=$SRC/${isim}-boot \
	--with-cacerts-file=/etc/ssl/certs/java/cacerts \
	--with-extra-cflags="$EXTRA_CFLAGS" \
	--with-extra-cxxflags="$EXTRA_CFLAGS" \
    --with-update-version="${_jdk_update}" \
    --with-build-number="b${_jdk_build}" \
	--with-milestone="fcs" \
	--with-zlib=system

LC_ALL=C \
make $MAKEFLAGS all
make install
