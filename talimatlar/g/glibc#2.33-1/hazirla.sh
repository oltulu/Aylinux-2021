cd $SRC
mkdir -p glibc-build lib32-glibc-build

  [[ -d glibc-$surum ]] && ln -s glibc-$surum glibc 
  cd glibc

  local i; for i in ${source[@]}; do
    case ${i%::*} in
      *.patch)
        echo "  -> Applying ${i}"
        patch -p1 -i "$SRC/${i}"
        ;;
    esac
  done
