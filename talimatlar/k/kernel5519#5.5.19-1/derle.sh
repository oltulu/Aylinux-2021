  set -e
  bsurum=5.5 
  LQX="$SRC/v5.5.19-lqx1.patch"
  cd "${SRC}/linux-${bsurum}"
  
  ### Add lqx patches
  sed -i -e s'/^+EXTRAVERSION = -lqx1/+EXTRAVERSION = /' $LQX
  patch -Np1 -i $LQX
  
  #çalışan sistem aufs yamaları
  patch -p1 -i "${SRC}/aufs5.patch"
  patch -p1 -i "${SRC}/aufs5-base.patch"
  patch -p1 -i "${SRC}/aufs5-kbuild.patch"
  patch -p1 -i "${SRC}/aufs5-loopback.patch"
  patch -p1 -i "${SRC}/aufs5-mmap.patch"
  #patch -p1 -i "${SRC}/aufs5-standalone.patch"
  #patch -p1 -i "${SRC}/tmpfs-idr.patch"
  #patch -p1 -i "${SRC}/vfs-ino.patch"
  #patch -p1 -i "${SRC}/rtlwifi.patch"
  
  # standart config
  cat "${SRC}/kernel-${bsurum}-config" > ./.config

  cat "${SRC}/kernel-${bsurum}-config.aufs" >> ./.config

  # kernel sürümüne devir sayısı eklemek için
  # set extraversion to release
  #sed -ri "s|^(EXTRAVERSION =).*|\1 -${devir}|" Makefile

  cd "${SRC}/linux-${bsurum}"
  
  export KBUILD_BUILD_USER="oltulu"
  export KBUILD_BUILD_HOST="mls.akdeniz.edu.tr"
  
  # ayarları onaylama
  make olddefconfig

  # derleme
  export LC_ALL=C
  make -j2 bzImage modules
  set +e
