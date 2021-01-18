_boostver=${surum//./_}

export _stagedir="${SRC}/stagedir"
local JOBS="$(sed -e 's/.*\(-j *[0-9]\+\).*/\1/' <<< ${MAKEFLAGS})"

cd ${isim}_${_boostver}

./bootstrap.sh --with-toolset=gcc --with-icu --with-python=/usr/bin/python2

install -Dm755 tools/build/src/engine/b2 "${_stagedir}"/bin/b2

install -dm755 "${_stagedir}"/share/boostbook
cp -a tools/boostbook/{xsl,dtd} "${_stagedir}"/share/boostbook/

"${_stagedir}"/bin/b2 \
  variant=release \
  debug-symbols=off \
  threading=multi \
  runtime-link=shared \
  link=shared,static \
  toolset=gcc \
  python=2.7 \
  cflags="${CPPFLAGS} ${CFLAGS} -fPIC -O3" \
  cxxflags="${CPPFLAGS} ${CXXFLAGS} -std=c++14 -fPIC -O3" \
  linkflags="${LDFLAGS}" \
  --layout=system \
  ${JOBS} \
  --prefix="${_stagedir}" \
  install

sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' -i bootstrap.sh

./bootstrap.sh \
 --with-toolset=gcc \
 --with-icu \
 --with-python=/usr/bin/python3 \
 --with-libraries=python

"${_stagedir}"/bin/b2 clean
"${_stagedir}"/bin/b2 \
  variant=release \
  debug-symbols=off \
  threading=multi \
  runtime-link=shared \
  link=shared,static \
  toolset=gcc \
  python=3.7 \
  cflags="${CPPFLAGS} ${CFLAGS} -fPIC -O3" \
  cxxflags="${CPPFLAGS} ${CXXFLAGS} -std=c++14 -fPIC -O3" \
  linkflags="${LDFLAGS}" \
  --layout=system \
  ${JOBS} \
  --prefix="${_stagedir}/python3" \
  --with-python \
  install
