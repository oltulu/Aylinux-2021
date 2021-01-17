#NOCONFIGURE=1 ./autogen.sh
autoreconf
./configure --prefix=/usr \
--enable-gles2 \
--enable-{kms,wayland}-egl-platform \
--enable-wayland-egl-server
make