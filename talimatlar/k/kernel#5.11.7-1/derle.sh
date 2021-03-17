  set -e
  bsurum=$surum
  cd "${SRC}/linux-${bsurum}"

  # standart config
  cat "${SRC}/kernel-${bsurum}-config" > ./.config
  
  export KBUILD_BUILD_USER="aylinux"
  export KBUILD_BUILD_HOST="aylinux.org"
  
  # ayarları onaylama
  make olddefconfig

  # derleme
  export LC_ALL=C
  make -j2 bzImage modules
  set +e
