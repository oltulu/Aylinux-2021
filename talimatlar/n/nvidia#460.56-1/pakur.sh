cd NVIDIA-Linux-x86_64-$surum

# X driver and GLX extension
install -d $PKG/usr/lib/xorg/modules/{drivers,extensions}
install -m 0755 nvidia_drv.so $PKG/usr/lib/xorg/modules/drivers/
install -d -m 0755 $PKG/usr/lib/nvidia/xorg
install -m 0755 libglxserver_nvidia.so.$surum $PKG/usr/lib/nvidia/xorg/
ln -s libglxserver_nvidia.so.$surum $PKG/usr/lib/nvidia/xorg/libglxserver_nvidia.so
ln -s libglxserver_nvidia.so.$surum $PKG/usr/lib/nvidia/xorg/libglxserver_nvidia.so.1

	# EGL and OpenGL ES libraries and config
install -d $PKG/usr/lib
install -m 0755 libGLESv1_CM_nvidia.so.$surum $PKG/usr/lib/
ln -s libGLESv1_CM_nvidia.so.$surum $PKG/usr/lib/libGLESv1_CM_nvidia.so.1
	install -m 0755 libGLESv2_nvidia.so.$surum $PKG/usr/lib/
	ln -s libGLESv2_nvidia.so.$surum $PKG/usr/lib/libGLESv2_nvidia.so.2
	install -D -m 0644 10_nvidia.json $PKG/usr/share/glvnd/egl_vendor.d/10_nvidia.json

	# wayland EGL library and config
	#install -d $PKG/usr/share/egl/egl_external_platform.d
	#install -m 0755 libnvidia-egl-wayland.so.1.0.2 $PKG/usr/lib/
	#install -m 0644 10_nvidia_wayland.json $PKG/usr/share/egl/egl_external_platform.d/

	# GLVND vendor implementation libraries
	install -m 0755 libGLX_nvidia.so.$surum $PKG/usr/lib/
	ln -s libGLX_nvidia.so.$surum $PKG/usr/lib/libGLX_nvidia.so.0
	install -m 0755 libEGL_nvidia.so.$surum $PKG/usr/lib/
	ln -s libEGL_nvidia.so.$surum $PKG/usr/lib/libEGL_nvidia.so.0

	# vulkan ICD config
	install -d $PKG/etc/vulkan/icd.d
	install -m 0644 nvidia_icd.json $PKG/etc/vulkan/icd.d/

	# driver component libraries
	install -m 0755 libnvidia-cfg.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-compiler.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-eglcore.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-glcore.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-glsi.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-glvkspirv.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-rtcore.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-cbl.so.$surum $PKG/usr/lib/

	# vendor VDPAU library
	install -D -m 0755 libvdpau_nvidia.so.$surum $PKG/usr/lib/vdpau/libvdpau_nvidia.so.$surum
	ln -s libvdpau_nvidia.so.$surum $PKG/usr/lib/vdpau/libvdpau_nvidia.so.1
	ln -s libvdpau_nvidia.so.$surum $PKG/usr/lib/vdpau/libvdpau_nvidia.so

	# CUDA libraries
	install -m 0755 libcuda.so.$surum $PKG/usr/lib/
	ln -s libcuda.so.$surum $PKG/usr/lib/libcuda.so.1
	ln -s libcuda.so.$surum $PKG/usr/lib/libcuda.so
	install -m 0755 libnvidia-ptxjitcompiler.so.$surum $PKG/usr/lib/
	ln -s libnvidia-ptxjitcompiler.so.$surum $PKG/usr/lib/libnvidia-ptxjitcompiler.so.1
	ln -s libnvidia-ptxjitcompiler.so.$surum $PKG/usr/lib/libnvidia-ptxjitcompiler.so

	# OpenCL libraries and config
	install -m 0755 libOpenCL.so.1.0.0 $PKG/usr/lib/
	install -m 0755 libnvidia-opencl.so.$surum $PKG/usr/lib/
	ln -s libnvidia-opencl.so.$surum $PKG/usr/lib/libnvidia-opencl.so.1
	ln -s libnvidia-opencl.so.$surum $PKG/usr/lib/libnvidia-opencl.so
	install -D -m 0644 nvidia.icd $PKG/etc/OpenCL/vendors/nvidia.icd

	# CUDA MPI applications
	install -d $PKG/usr/bin
	install -m 0755 nvidia-cuda-mps-control $PKG/usr/bin/
	install -m 0755 nvidia-cuda-mps-server $PKG/usr/bin/

	# TLS libraries
	install -m 0755 libnvidia-tls.so.$surum $PKG/usr/lib/

	# monitoring and management API library
	install -m 0755 libnvidia-ml.so.$surum $PKG/usr/lib/
	ln -s libnvidia-ml.so.$surum $PKG/usr/lib/libnvidia-ml.so.1
	ln -s libnvidia-ml.so.$surum $PKG/usr/lib/libnvidia-ml.so

	# applications
	install -m 4755 nvidia-modprobe $PKG/usr/bin/
	install -m 0755 nvidia-{xconfig,settings,smi,debugdump,persistenced} \
		$PKG/usr/bin/

	# nvidia-settings UI libraries
	install -m 0755 libnvidia-gtk{2,3}.so.$surum $PKG/usr/lib/

	# encoding/decoding libraries
	install -m 0755 libnvcuvid.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-encode.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-ifr.so.$surum $PKG/usr/lib/
	install -m 0755 libnvidia-fbc.so.$surum $PKG/usr/lib/

	# OptiX ray tracing engine
	install -m 0755 libnvoptix.so.$surum $PKG/usr/lib/
	ln -s libnvoptix.so.$surum $PKG/usr/lib/libnvoptix.so.1
	ln -s libnvoptix.so.$surum $PKG/usr/lib/libnvoptix.so

	# Optical Flow library
	install -m 0755 libnvidia-opticalflow.so.$surum $PKG/usr/lib/
	ln -s libnvidia-opticalflow.so.$surum $PKG/usr/lib/libnvidia-opticalflow.so.1
	ln -s libnvidia-opticalflow.so.$surum $PKG/usr/lib/libnvidia-opticalflow.so

	# NGX library
	install -m 0755 libnvidia-ngx.so.$surum $PKG/usr/lib/
	ln -s libnvidia-ngx.so.$surum $PKG/usr/lib/libnvidia-ngx.so.1
	ln -s libnvidia-ngx.so.$surum $PKG/usr/lib/libnvidia-ngx.so

	# X driver config
	install -D -m 0644 $SRC/10-nvidia-drm-outputclass.conf \
		$PKG/usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf

	# application profile keys and documentation
	install -d -m 0755 $PKG/usr/share/nvidia
	install -m 0644 nvidia-application-profiles-$surum-rc $PKG/usr/share/nvidia/
	install -m 0644 nvidia-application-profiles-$surum-key-documentation $PKG/usr/share/nvidia/

	# desktop file and icon
	install -d $PKG/usr/share/{applications,pixmaps}
	sed -i -e 's,__UTILS_PATH__,/usr/bin,' -e 's,__PIXMAP_PATH__,/usr/share/pixmaps,' nvidia-settings.desktop
	install -m 0644 nvidia-settings.desktop $PKG/usr/share/applications/
	install -m 0644 nvidia-settings.png $PKG/usr/share/pixmaps/

	# nvidia-uvm udev rules file
	install -D -m 0644 $SRC/90-nvidia-uvm.rules $PKG/lib/udev/rules.d/90-nvidia-uvm.rules

	# kernel modules
	cd kernel
	IGNORE_CC_MISMATCH=1 make module
	install -d $PKG/lib/modules/$(uname -r)/extra
	install -m 0644 *.ko $PKG/lib/modules/$(uname -r)/extra/
