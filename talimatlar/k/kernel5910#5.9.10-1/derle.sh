  set -e
  bsurum=5.9.10
  cd "${SRC}/linux-${bsurum}"

  # standart config
  cat "${SRC}/kernel-${bsurum}-config" > ./.config
  
  export KBUILD_BUILD_USER="milisarge"
  export KBUILD_BUILD_HOST="mls.akdeniz.edu.tr"
  
  # ayarları onaylama
  make olddefconfig

  # derleme
  export LC_ALL=C
  make -j2 bzImage modules
  set +e
