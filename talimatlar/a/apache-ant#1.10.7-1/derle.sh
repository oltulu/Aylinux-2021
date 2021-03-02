#wget https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt
#make-ca
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
./bootstrap.sh
bootstrap/bin/ant -Ddest=optional -f fetch.xml
rm  lib/optional/junit-4.12.jar           && ln -s /usr/share/java/junit.jar            lib/optional/junit-4.12.jar
#rm  lib/optional/hamcrest-core-1.3.jar    && ln -s /usr/share/java/hamcrest-core.jar    lib/optional/hamcrest-core-1.3.jar
#rm  lib/optional/hamcrest-library-1.3.jar && ln -s /usr/share/java/hamcrest-library.jar lib/optional/hamcrest-library-1.3.jar
bootstrap/bin/ant dist
