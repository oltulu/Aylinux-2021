[ -e '/usr/include/AMF/core/VulkanAMF.h' ] && PKGMK_FFMPEG+=' --enable-amf'
[ -e '/usr/bin/clang' ] && [ -e '/usr/lib/pkgconfig/cuda.pc' ] && PKGMK_FFMPEG+=' --enable-cuda-llvm'
[ -e '/usr/lib/pkgconfig/libwebp.pc' ] && PKGMK_FFMPEG+=' --enable-libwebp'
[ -e '/usr/lib/pkgconfig/vdpau.pc' ] && PKGMK_FFMPEG+=' --enable-vdpau'
[ -e '/usr/lib/pkgconfig/freetype2.pc' ] && PKGMK_FFMPEG+=' --enable-libfreetype'
[ -e '/usr/lib/pkgconfig/x264.pc' ] && PKGMK_FFMPEG+=' --enable-libx264'
[ -e '/usr/lib/pkgconfig/x265.pc' ] && PKGMK_FFMPEG+=' --enable-libx265'
[ -e '/usr/lib/pkgconfig/libass.pc' ] && PKGMK_FFMPEG+=' --enable-libass'
[ -e '/usr/lib/libgsm.so' ] && PKGMK_FFMPEG+=' --enable-libgsm'
[ -e '/usr/include/lame/lame.h' ] && PKGMK_FFMPEG+=' --enable-libmp3lame'
[ -e '/usr/lib/pkgconfig/opus.pc' ] && PKGMK_FFMPEG+=' --enable-libopus'
[ -e '/usr/lib/pkgconfig/vpx.pc' ] && PKGMK_FFMPEG+=' --enable-libvpx'
[ -e '/usr/lib/pkgconfig/vorbis.pc' ] && PKGMK_FFMPEG+=' --enable-libvorbis'
[ -e '/usr/lib/pkgconfig/theora.pc' ] && PKGMK_FFMPEG+=' --enable-libtheora'
#[ -e '/usr/lib/pkgconfig/libpulse.pc' ] && PKGMK_FFMPEG+=' --enable-libpulse'
[ -e '/usr/lib/pkgconfig/fdk-aac.pc' ] && PKGMK_FFMPEG+=' --enable-libfdk-aac --enable-nonfree'
[ -e '/usr/lib/pkgconfig/dav1d.pc' ] && PKGMK_FFMPEG+=' --enable-libdav1d'

	if [ -e '/usr/lib/pkgconfig/gnutls.pc' ]; then
		PKGMK_FFMPEG+=' --enable-gnutls'
	else
		PKGMK_FFMPEG+=' --enable-openssl --enable-nonfree'
	fi

	./configure ${PKGMK_FFMPEG} \
		--prefix=/usr \
		--disable-debug \
		--disable-doc \
		--enable-gpl \
		--enable-version3 \
		--enable-shared \
		--enable-pic \
		--enable-ffplay \
		--enable-avfilter \
		--enable-postproc \
		--enable-pthreads \
		--enable-swresample \
		--enable-avresample

	make
