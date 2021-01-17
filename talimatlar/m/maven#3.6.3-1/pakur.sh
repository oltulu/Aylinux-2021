binsurum=3.5.4
MVN_HOME=/usr/share/maven

cd "$SRC"/apache-maven-$surum
 export PATH="/usr/lib/jvm/java-8-openjdk/bin:${SRC}/apache-maven-${binsurum}/bin:${PATH}"
mvn package \
-DskipTests \
-Drat.skip=true \
-Dmaven.repo.local=repo \
-DdistributionTargetDir=${PKG}/${MVN_HOME}/ \
-Dproject.build.sourceEncoding=UTF-8 -e

install -Dm 755 $SRC/maven.sh -t "${PKG}/etc/profile.d"

# disables ansi color support
rm -rf ${PKG}/${MVN_HOME}/lib/jansi-native
rm -f ${PKG}/${MVN_HOME}/${pkgname}/lib/jansi-*.jar

install -d "${PKG}/usr/bin"
ln -s ${MVN_HOME}/bin/mvn "${PKG}/usr/bin/mvn"
ln -s ${MVN_HOME}/bin/mvnDebug "${PKG}/usr/bin/mvnDebug"
