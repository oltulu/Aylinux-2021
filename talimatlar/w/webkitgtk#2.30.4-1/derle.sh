cd $SRC
# Make sure we do not have ccache masquerade directory in PATH.
	[ -e '/usr/bin/ccache' ] && PATH="$(echo ${PATH} | awk -v RS=: -v ORS=: '/ccache/ {next} {print}' | sed 's/:*$//')"

	prt-get isinst openjpeg2 || PKGMK_WEBKITGTK+=' -DUSE_OPENJPEG=OFF'
	prt-get isinst enchant || PKGMK_WEBKITGTK+=' -DENABLE_SPELLCHECK=OFF'
	prt-get isinst libnotify && PKGMK_WEBKITGTK+=' -DUSE_LIBNOTIFY=ON' || PKGMK_WEBKITGTK+=' -DUSE_LIBNOTIFY=OFF'
	prt-get isinst geoclue && PKGMK_WEBKITGTK+=' -DENABLE_GEOLOCATION=ON' || PKGMK_WEBKITGTK+=' -DENABLE_GEOLOCATION=OFF'
	prt-get isinst bubblewrap && prt-get isinst xdg-dbus-proxy && PKGMK_WEBKITGTK+=' -DENABLE_BUBBLEWRAP_SANDBOX=ON' \
	|| PKGMK_WEBKITGTK+=' -DENABLE_BUBBLEWRAP_SANDBOX=OFF'

	cmake -S $isim-$surum -B build -G Ninja ${PKGMK_WEBKITGTK} \
		-D CMAKE_INSTALL_PREFIX:PATH=/usr \
		-D CMAKE_INSTALL_LIBDIR:PATH=/usr/lib \
		-D CMAKE_INSTALL_LIBEXECDIR:PATH=/usr/lib \
		-D CMAKE_BUILD_TYPE=Release \
		-D CMAKE_CXX_FLAGS_RELEASE="$CXXFLAGS -DNDEBUG" \
		-D CMAKE_C_FLAGS_RELEASE="$CFLAGS -DNDEBUG" \
		-D CMAKE_SKIP_RPATH:BOOL=ON \
		-D PORT=GTK \
		-D ENABLE_MINIBROWSER=ON \
		-D USE_SYSTEM_MALLOC=ON \
		-D USE_SYSTEMD=OFF \
		-Wno-dev

	cmake --build build
