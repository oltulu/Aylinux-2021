cd $SRC
milis-meson $isim-$surum build \
-D loongson-mmi=disabled \
-D vmx=disabled \
-D arm-simd=disabled \
-D neon=disabled \
-D iwmmxt=disabled \
-D mips-dspr2=disabled \
-D gtk=disabled
ninja -C build
