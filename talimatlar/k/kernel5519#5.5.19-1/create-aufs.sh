#!/bin/bash

rm -Rf aufs5-standalone
# clone the aufs repository to the local disk
surum=$1
git clone git://github.com/sfjro/aufs5-standalone.git aufs5-standalone
cd aufs5-standalone
git branch -r
git checkout origin/aufs${surum}

# modify what you want

# and after
# create the patch with the directories: fs, include and Documentation

rm -fv $(find . -type f -name '*.orig')
grep -qse 'EXPORT_SYMBOL(' aufs5-standalone.patch && \
sed -i-old -e 's|EXPORT_SYMBOL(|EXPORT_SYMBOL_GPL(|' aufs5-standalone.patch
rm -rf ../tmp/linux-${surum}
mkdir -p ../tmp/linux-${surum}
cp -a fs ../tmp/linux-${surum}
cp -a include ../tmp/linux-${surum}
cp -a Documentation ../tmp/linux-${surum}
rm ../tmp/linux-${surum}/include/uapi/linux/Kbuild
cd ../tmp
diff -Naur null linux-${surum}  | filterdiff | \
sed -e 's|null\(/include/uapi/linux/Kbuild\)|linux-${surum}-old\1|;s|^--- null.*|--- /dev/null|;\|linux-${surum}/include/uapi/linux/Kbuild|,${\|@@ -0,0 +1 @@|,$d}' \
| bzip2 > aufs$(sed -ne 's|#define.*AUFS_VERSION.*"\(.*\)"|\1|p'  linux-${surum}/include/uapi/linux/aufs_type.h).patch.bz2
mv *.bz2 $OLDPWD
cd $OLDPWD
mv *patch* ..
cd ..
rm -rf tmp aufs5-standalone


# the patch is created in ../tmp
# the other patches needed to compile are in the base directory
