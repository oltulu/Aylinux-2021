_core_perl="/usr/bin/core_perl"
_py3_ver=$(python --version | cut -d " " -f2)
path="${PWD}/libraries/libapparmor/swig/python/build/lib.linux-${CARCH}-${_py3_ver%"."*}/LibAppArmor"
libs="${PWD}/libraries/libapparmor/src/.libs"
sed -e "/PYTHONPATH/ s|utils\ |utils:$path\ LD_LIBRARY_PATH=$libs\ |" -i profiles/Makefile

export MAKEFLAGS+=" POD2MAN=${_core_perl}/pod2man"
export MAKEFLAGS+=" POD2HTML=${_core_perl}/pod2html"
export MAKEFLAGS+=" PODCHECKER=${_core_perl}/podchecker"
export MAKEFLAGS+=" PROVE=${_core_perl}/prove"
  
cd libraries/libapparmor
autoreconf -ivf
./configure --prefix=/usr --sbindir=/usr/bin --with-perl --with-python
make 

cd $SRC/apparmor-$surum
make ${MAKEJOBS} -C binutils
make ${MAKEJOBS} -C utils
make ${MAKEJOBS} -C parser
make ${MAKEJOBS} -C profiles
