# https://bugzilla.mozilla.org/show_bug.cgi?id=1530052
	patch -p1 -i $SRC/0001-Use-remoting-name-for-GDK-application-names.patch

	if [ $(/usr/bin/python -c "import sys; print sys.stdout.encoding") = 'UTF-8' ]; then
		printf "\e[031mError: set an UTF-8 locale to compile this!\033[0m\n"
		exit 1
	fi

	if [ -e '/usr/bin/ccache' ]; then
		export OS_CCACHE_COMPILERCHECK="$(/usr/bin/clang -dumpversion | sed -z 's/\n/ /g'; crux | cut -d' ' -f3)"
		export CCACHE_COMPILERCHECK="string:$OS_CCACHE_COMPILERCHECK"
		PATH=$(echo ${PATH} | awk -v RS=: -v ORS=: '/ccache/ {next} {print}' | sed 's/:*$//')
	fi	

	prt-get isinst sccache && export RUSTC_WRAPPER=/usr/bin/sccache
	mkdir "$PKGMK_SOURCE_DIR/rust" || true
	export CARGO_HOME="$PKGMK_SOURCE_DIR/rust"

cat <<- EOF > .mozconfig
	mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-shared
	unset MOZ_TELEMETRY_REPORTING
	ac_add_options --prefix=/usr
	ac_add_options --enable-default-toolkit=cairo-gtk3
	ac_add_options --enable-application=browser
	ac_add_options --with-system-jpeg
	ac_add_options --with-system-zlib
	ac_add_options --with-system-png
	ac_add_options --with-system-nspr
	ac_add_options --with-system-nss
	ac_add_options --enable-av1
	ac_add_options --enable-system-ffi
	ac_add_options --enable-system-pixman
	ac_add_options --enable-alsa
	ac_add_options --enable-optimize
	ac_add_options --enable-release
	ac_add_options --enable-rust-simd
	ac_add_options --disable-debug-symbols
	ac_add_options --disable-pulseaudio
	ac_add_options --enable-official-branding
	ac_add_options --with-distribution-id=nu.crux
	ac_add_options --enable-extensions=default,-gnomevfs
	ac_add_options --enable-linker=lld
	ac_add_options --disable-tests
	ac_add_options --disable-debug
	ac_add_options --disable-updater
	ac_add_options --disable-crashreporter
	ac_add_options --disable-necko-wifi
	ac_add_options --disable-elf-hack
EOF

	[[ -e '/usr/bin/ccache' ]] && echo 'ac_add_options --enable-ccache' >> .mozconfig

	export CC=clang CXX=clang++ AR=llvm-ar NM=llvm-nm RANLIB=llvm-ranlib
	export MOZ_MAKE_FLAGS="-j ${JOBS-1}"
	export MOZBUILD_STATE_PATH="$PKGMK_SOURCE_DIR/.mozbuild"
	export MOZ_NOSPAM=1
	export MACH_USE_SYSTEM_PYTHON=1

	./mach build
	#./mach build toolkit/library/rust
	DESTDIR=$PKG ./mach install

