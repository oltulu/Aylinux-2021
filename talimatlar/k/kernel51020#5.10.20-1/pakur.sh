  bsurum=5.10.20
  cd "${SRC}/linux-${bsurum}"
  KARCH=x86

  # get kernel version
  #_kernver="$(make kernelrelease)"
  #KERNEL_VERSION="${surum}-milis"
  _kernver="${surum}-aylinux"
  mkdir -p ${PKG}/usr/lib/modules
  mkdir -p ${PKG}/usr/lib/firmware
  mkdir -p ${PKG}/boot
  
  make INSTALL_MOD_PATH=${PKG}/usr INSTALL_MOD_STRIP=1 modules_install
  cp arch/$KARCH/boot/bzImage "${PKG}/boot/kernel-${surum}"
  
  # vmlinux un source a eklenmesi,modül derlerken bu geçici silinecek
  #install -D -m644 vmlinux "${PKG}/usr/src/linux-${_kernver}/vmlinux"

  # derleme kalıntılarının temizlenmesi
  rm -f "${PKG}"/usr/lib/modules/${_kernver}/{source,build}
  # firmwarelerin temizlenmesi
  rm -rf "${PKG}/usr/lib/firmware"
  
  # modüllerin sıkıştırılarak ek yer kazanılması
  find "${PKG}" -name '*.ko' -exec gzip -9 {} \;
  
  #linux-headers / linux modülleri

  install -dm755 "${PKG}/usr/lib/modules/${_kernver}"

  cd "${PKG}/usr/lib/modules/${_kernver}"
  ln -sf /usr/src/linux-${_kernver} build

  cd "${SRC}/linux-${bsurum}"
  install -D -m644 Makefile "${PKG}/usr/src/linux-${_kernver}/Makefile"
  install -D -m644 kernel/Makefile "${PKG}/usr/src/linux-${_kernver}/kernel/Makefile"
  install -D -m644 .config "${PKG}/usr/src/linux-${_kernver}/.config"

  ######################
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/include"

  for i in acpi asm-generic config crypto drm generated keys linux math-emu \
    media net pcmcia scsi rdma soc sound target trace uapi vdso video xen; do
    cp -a include/${i} "${PKG}/usr/src/linux-${_kernver}/include/"
  done

  # copy arch includes for external modules
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/arch/x86"
  cp -a arch/x86/include "${PKG}/usr/src/linux-${_kernver}/arch/x86/"

  # copy files necessary for later builds, like nvidia and vmware
  cp Module.symvers "${PKG}/usr/src/linux-${_kernver}"
  cp -a scripts "${PKG}/usr/src/linux-${_kernver}"

  # fix permissions on scripts dir
  chmod og-w -R "${PKG}/usr/src/linux-${_kernver}/scripts"
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/.tmp_versions"

  mkdir -p "${PKG}/usr/src/linux-${_kernver}/arch/x86/kernel"

  cp arch/x86/Makefile "${PKG}/usr/src/linux-${_kernver}/arch/x86/"

  cp arch/x86/kernel/asm-offsets.s "${PKG}/usr/src/linux-${_kernver}/arch/x86/kernel/"

  # add headers for lirc package
  # pci
  for i in bt8xx cx88 saa7134; do
    mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/pci/${i}"
    cp -a drivers/media/pci/${i}/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/pci/${i}"
  done
  # usb
  for i in cpia2 em28xx pwc; do
    mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/usb/${i}"
    cp -a drivers/media/usb/${i}/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/usb/${i}"
  done
  # i2c
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/i2c"
  cp drivers/media/i2c/*.h  "${PKG}/usr/src/linux-${_kernver}/drivers/media/i2c/"
  for i in cx25840; do
    mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/i2c/${i}"
    cp -a drivers/media/i2c/${i}/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/i2c/${i}"
  done

  # add docbook makefile
  #install -D -m644 Documentation/DocBook/Makefile \
  #  "${PKG}/usr/src/linux-${_kernver}/Documentation/DocBook/Makefile"

  # add dm headers
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/md"
  cp drivers/md/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/md"

  # add inotify.h
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/include/linux"
  cp include/linux/inotify.h "${PKG}/usr/src/linux-${_kernver}/include/linux/"

  # add wireless headers
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/net/mac80211/"
  cp net/mac80211/*.h "${PKG}/usr/src/linux-${_kernver}/net/mac80211/"

  # add dvb headers for external modules
  #mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/dvb-core"
  #cp drivers/media/dvb-core/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/dvb-core/"
  # and...
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/include/config/dvb/"
  cp include/config/dvb/*.h "${PKG}/usr/src/linux-${_kernver}/include/config/dvb/"

  # add dvb headers for http://mcentral.de/hg/~mrec/em28xx-new
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends/"
  cp drivers/media/dvb-frontends/lgdt330x.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends/"
  cp drivers/media/i2c/msp3400-driver.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/i2c/"

  # add dvb headers
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/usb/dvb-usb"
  cp drivers/media/usb/dvb-usb/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/usb/dvb-usb/"
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends"
  cp drivers/media/dvb-frontends/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/dvb-frontends/"
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/drivers/media/tuners"
  cp drivers/media/tuners/*.h "${PKG}/usr/src/linux-${_kernver}/drivers/media/tuners/"

  # add xfs and shmem for aufs building
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/fs/xfs/libxfs"
  mkdir -p "${PKG}/usr/src/linux-${_kernver}/mm"
  cp fs/xfs/libxfs/xfs_sb.h "${PKG}/usr/src/linux-${_kernver}/fs/xfs/libxfs/xfs_sb.h"

  #aufs4-util need
  #sed -i "s:__user::g" "${PKG}/usr/src/linux-${_kernver}/include/uapi/linux/aufs_type.h"

  # copy in Kconfig files
  for i in `find . -name "Kconfig*"`; do
    mkdir -p "${PKG}"/usr/src/linux-${_kernver}/`echo ${i} | sed 's|/Kconfig.*||'`
    cp ${i} "${PKG}/usr/src/linux-${_kernver}/${i}"
  done

  chown -R root.root "${PKG}/usr/src/linux-${_kernver}"
  find "${PKG}/usr/src/linux-${_kernver}" -type d -exec chmod 755 {} \;

  # strip scripts directory
  find "${PKG}/usr/src/linux-${_kernver}/scripts" -type f -perm -u+w 2>/dev/null | while read binary ; do
    case "$(file -bi "${binary}")" in
      *application/x-sharedlib*) # Libraries (.so)
        strip -v ${STRIP_SHARED} "${binary}";;
      *application/x-archive*) # Libraries (.a)
        strip -v ${STRIP_STATIC} "${binary}";;
      *application/x-executable*) # Binaries
        strip -v ${STRIP_BINARIES} "${binary}";;
      *application/x-pie-executable*) # Relocatable binaries
        strip -v ${STRIP_SHARED} "${binary}";;
    esac
  done

  # add objtool, nvidia needed
  install -Dt "${PKG}/usr/src/linux-${_kernver}/tools/objtool" tools/objtool/objtool

  # remove unneeded architectures
  for rmarch in "${PKG}/usr/src/linux-${_kernver}"/arch/*/; do
    [[ $rmarch = */x86/ ]] && continue
    rm -r "$rmarch"
  done
