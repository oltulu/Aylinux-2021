	cd mesa-$surum

	CONFIG_SHELL=/bin/bash \
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--enable-llvm \
		--enable-gbm \
		--enable-gles1 \
		--enable-gles2 \
		--enable-glx-tls \
		--enable-osmesa \
		--enable-texture-float \
		--enable-xa \
		--enable-vdpau \
		--enable-llvm-shared-libs \
		--disable-dependency-tracking \
		--with-platforms=x11,drm,wayland \
		--with-gallium-drivers=r300,r600,svga,swrast,radeonsi,nouveau  \
		--with-vulkan-drivers=intel,radeon

	make