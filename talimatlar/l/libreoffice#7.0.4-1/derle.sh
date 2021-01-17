noextract=(35c94d2df8893241173de1d16b6034c0-swingExSrc.zip
798b2ffdc8bcfe7bca2cf92b62caf685-rhino1_5R5.zip
a7983f859eafb2677d7ff386a023bc40-xsltml_2.1.2.zip
0168229624cfac409e766913506961a8-ucpp-1.3.2.tar.gz
language-subtag-registry-2019-04-03.tar.bz2
17410483b5b5f267aa18b7e00b65e6e0-hsqldb_1_8_0.zip
d8bd5eed178db6e2b18eeed243f85aa8-flute-1.1.6.zip
ba2930200c9f019c2d93a8c88c651a0f-flow-engine-0.9.4.zip
pdfium-3794.tar.bz2
lxml-4.1.1.tgz
Firebird-3.0.0.32483-0.tar.bz2
libstaroffice-0.0.6.tar.xz
libzmf-0.0.2.tar.xz
poppler-0.74.0.tar.xz
beeca87be45ec87d241ddd0e1bad80c1-bsh-2.0b6-src.zip
8249374c274932a21846fa7629c2aa9b-officeotron-0.7.4-master.jar
odfvalidator-1.2.0-incubating-SNAPSHOT-jar-with-dependencies-971c54fd38a968f5860014b44301872706f9e540.jar 
884ed41809687c3e168fc7c19b16585149ff058eca79acbf3ee784f6630704cc-opens___.ttf
185d60944ea767075d27247c3162b3bc-unowinreg.dll
)

# move external sources into place
mkdir "${SRC}"/ext_sources && pushd "${SRC}"/ext_sources
for source in "${noextract[@]}"; do
	ln -s "${KAYNAKLAR_DEPO}"/$source .
done
popd

# unowinreg.dll must be a file not a symlink or the result will become a broken symlink
# /usr/share/libreoffice/sdk/classes/win/unowinreg.dll -> /build/libreoffice/src/185d60944ea767075d27247c3162b3bc-unowinreg.dll
rm "${SRC}"/ext_sources/185d60944ea767075d27247c3162b3bc-unowinreg.dll
cp -f "${KAYNAKLAR_DEPO}"/185d60944ea767075d27247c3162b3bc-unowinreg.dll "${SRC}"/ext_sources

# fix not upstreamable pyuno paths - FS#54250
#patch -Np1 -i "${SRC}"/make-pyuno-work-with-system-wide-module-install.diff

#use the CFLAGS but remove the LibO overridden ones
for i in $CFLAGS; do
	case "$i" in
		-O?|-pipe|-Wall|-g|-fexceptions) continue;;
	esac
	ARCH_FLAGS="$ARCH_FLAGS $i"
done

# strip -s from Makeflags in case you use it to shorten build logs
_MAKEFLAGS=${MAKEJOBS/-s/}

# http://site.icu-project.org/download/61#TOC-Migration-Issues
CPPFLAGS+=' -DU_USING_ICU_NAMESPACE=1'

./autogen.sh --with-build-version="${surum}-${devir}" \
	--with-vendor="Milis Linux" \
	--enable-split-app-modules \
	--with-parallelism=${_MAKEFLAGS/-j/} \
	--with-external-tar="${SRC}/ext_sources" \
	--disable-fetch-external \
	--enable-release-build \
	--prefix=/usr --exec-prefix=/usr --sysconfdir=/etc \
	--libdir=/usr/lib --mandir=/usr/share/man \
	--with-lang="tr" \
	--with-help=html \
	--disable-avahi \
	--enable-dbus \
	--enable-gio\
	--enable-qt5 \
	--enable-gtk3 \
	--enable-introspection \
	--disable-gstreamer-0-10 \
	--enable-openssl \
	--enable-odk\
	--enable-python=system \
	--enable-scripting-javascript \
	--disable-dconf \
	--disable-report-builder \
	--disable-online-update \
	--enable-ext-wiki-publisher \
	--enable-ext-nlpsolver \
	--without-fonts\
	--with-system-apr \
	--with-system-libcdr \
	--with-system-mdds\
	--without-myspell-dicts \
	--with-system-libvisio \
	--with-system-libcmis \
	--with-system-libmspub \
	--with-system-libexttextcat \
	--with-system-orcus \
	--with-system-liblangtag \
	--with-system-libodfgen \
	--with-system-libmwaw \
	--with-system-libetonyek \
	--with-system-libfreehand \
	--without-system-firebird \
	--with-system-libtommath \
	--with-system-libatomic-ops \
	--with-system-libebook \
	--with-system-libabw \
	--with-system-coinmp \
	--with-system-dicts \
	--with-external-dict-dir=/usr/share/hunspell \
	--with-external-hyph-dir=/usr/share/hyphen \
	--with-external-thes-dir=/usr/share/mythes \
	--with-system-cppunit\
	--with-system-graphite\
	--with-system-glm \
	--with-system-libnumbertext \
	--with-system-libwpg \
	--with-system-libwps \
	--with-system-redland\
	--with-system-gpgmepp \
	--with-system-serf \
	--with-jdk-home="/usr/lib/jvm/java-8-openjdk" \
	--with-ant-home="/usr/share/apache-ant"\
	--without-junit \
	--with-system-boost\
	--with-system-icu \
	--with-system-cairo \
	--with-system-libs \
	--with-system-mythes \
	--with-system-headers \
	--without-system-hsqldb \
	--with-system-clucene \
	--disable-dependency-tracking \
	--without-system-poppler \
	--without-system-libzmf \
	--without-system-libstaroffice \
	--without-system-jfreereport \
	--without-system-apache-commons \
	--without-system-beanshell \
	--without-doxygen

touch src.downloaded

sed -i '/bootstrap: check-if-root compilerplugins/c\bootstrap: compilerplugins' Makefile

make build-nocheck

mkdir "${SRC}"/fakeinstall
make DESTDIR="${SRC}"/fakeinstall distro-pack-install
