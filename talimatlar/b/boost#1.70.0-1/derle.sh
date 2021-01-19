cd boost_1_70_0
./bootstrap.sh --prefix=/usr --with-python=/usr/bin/python2
./b2 stage --stagedir=$PKG/usr threading=multi link=shared
./b2 install --prefix=$PKG/usr threading=multi link=shared --build-dir=py2build

sed -e '/using python/ s@;@: /usr/include/python${PYTHON_VERSION/3*/${PYTHON_VERSION}m} ;@' \
      -i bootstrap.sh
./bootstrap.sh --prefix=$PKG/usr --with-python=/usr/bin/python3 --with-libraries=python

./b2 clean
./b2 install \
link=shared \
python=3.7 \
--build-dir=py3build \
--with-python

ln -svf detail/sha1.hpp $PKG/usr/include/boost/uuid/sha1.hpp