cd $/SRC
source=(/sources/$isim-$surum.tar.xz
  /sources/$isim-dictionaries-$surum.tar.xz
  /sources/185d60944ea767075d27247c3162b3bc-unowinreg.dll
  /sources/0168229624cfac409e766913506961a8-ucpp-1.3.2.tar.gz
 /sources/dtoa-20180411.tgz
  /sources/skia-m88-59bafeeaa7de9eb753e3778c414e01dcf013dcd8.tar.xz
  /sources/pdfium-4306.tar.bz2)
  
for file in ${source[@]}; do
    case ${file##*/} in
      libreoffice-*.tar.xz)
        bsdtar -p -o -C $SRC -xf $(get_filename $file) ;;
      185d60944ea767075d27247c3162b3bc-unowinreg.dll)
        mkdir $SRC/tarballs || true
        cp $(get_filename $file) $SRC/tarballs ;;
      0168229624cfac409e766913506961a8-ucpp-1.3.2.tar.gz)
        mkdir $SRC/tarballs || true
        cp $(get_filename $file) $SRC/tarballs ;;
      pdfium-$pdfiumversion.tar.bz2)
        mkdir $SRC/tarballs || true
        cp $(get_filename $file) $SRC/tarballs ;;
      dtoa-20180411.tgz)
        mkdir $SRC/tarballs || true
        cp $(get_filename $file) $SRC/tarballs ;;
      skia-m88-59bafeeaa7de9eb753e3778c414e01dcf013dcd8.tar.xz)
        mkdir $SRC/tarballs || true
        cp $(get_filename $file) $SRC/tarballs ;;
      *)
        cp $(get_filename $file) $SRC ;;
    esac
  done
  
  cd $/SRC/$isim-$surum

 # patch -Np1 -i $SRC/makefile.in.patch

  find -L . \
     \( -perm 777 -o -perm 775 -o -perm 750 -o -perm 711 -o -perm 555 \
     -o -perm 511 \) -exec chmod 755 {} \; -o \
     \( -perm 666 -o -perm 664 -o -perm 640 -o -perm 600 -o -perm 444 \
     -o -perm 440 -o -perm 400 \) -exec chmod 644 {} \;

  # determine configure options based on installed packages on the system
  [[ -e /usr/lib/ccache ]] && PATH="$(echo ${PATH} | awk -v RS=: -v ORS=: '/ccache/ {next} {print}' | sed 's/:*$//')"
  [[ -e /usr/lib/ccache ]] && PKGMK_LIBREOFFICE+=" --enable-ccache" || PKGMK_LIBREOFFICE+=" --disable-ccache"
  [[ -e /usr/lib/cups ]] && PKGMK_LIBREOFFICE+=" --enable-cups" || PKGMK_LIBREOFFICE+=" --disable-cups"
  [[ -e /usr/lib/pkgconfig/Qt5Core.pc ]] && PKGMK_LIBREOFFICE+=" --enable-qt5" || PKGMK_LIBREOFFICE+=" --disable-qt5"
  [[ -e /usr/include/KF5/KIOCore ]] && PKGMK_LIBREOFFICE+=" --enable-kde5 --enable-gtk3-kde5"
  [[ -e /usr/lib/pkgconfig/valgrind.pc ]] && PKGMK_LIBREOFFICE+=" --with-valgrind"

  local build_date=$(date +%Y%m%d)
  ./autogen.sh $PKGMK_LIBREOFFICE \
    --with-parallelism=${JOBS-1} \
    --prefix=/usr \
    --with-external-tar="$SRC/tarballs" \
    --enable-{build-opensymbol,dbus,firebird-sdbc=no,gtk3,introspection=yes,release-build,odk,openssl,pdfium,python=system} \
    --with-{lang="",package-format=archive,myspell-dicts,parallelism} \
    --with-extra-buildid="$(crux | awk '{ print $1 " " $3 }') ${build_date}" \
    --with-package-version="$version" \
    --with-system-{headers,libs} \
    --with-external-dict-dir=/usr/share/hunspell \
    --with-external-hyph-dir=/usr/share/hypen \
    --with-external-thes-dir=/usr/share/mythes \
    --without-{doxygen,fonts,gssapi,help,helppack-integration,java,system-firebird} \
    --disable-{avahi,build-unowinreg,dconf,dependency-tracking,extension-update,fetch-external} \
    --disable-{firebird-sdbc,poppler,postgresql-sdbc,report-builder,sdremote-bluetooth,werror}

  touch {sources.ver,src.downloaded}
  echo "lo_sources_ver=${surum}" > sources.ver
  make build-nocheck

  pushd workdir/installation/LibreOffice/archive/install/en-US
  tar xf *.tar.gz
  popd
