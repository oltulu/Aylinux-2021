_google_api_key=AIzaSyDwr302FpOSkGRpLlUpPThNTDPbXcIn_FM
_mozilla_api_key=e05d56db0a694edc8b5aaebda3f2db6a

mkdir $SRC/mozbuild

mkdir "$KAYNAKLAR_DEPO/rust" || true
export CARGO_HOME="$KAYNAKLAR_DEPO/rust"

# https://bugzilla.mozilla.org/show_bug.cgi?id=1530052
patch -Np1 -i ../0001-Use-remoting-name-for-GDK-application-names.patch

echo -n "$_google_api_key" >google-api-key
echo -n "$_mozilla_api_key" >mozilla-api-key

  cat >.mozconfig <<END
ac_add_options --enable-application=browser

ac_add_options --prefix=/usr
ac_add_options --enable-release
ac_add_options --enable-hardening
ac_add_options --enable-optimize
ac_add_options --enable-rust-simd
export CC='clang --target=x86_64-unknown-linux-gnu'
export CXX='clang++ --target=x86_64-unknown-linux-gnu'
export AR=llvm-ar
export NM=llvm-nm
export RANLIB=llvm-ranlib

# Branding
ac_add_options --enable-official-branding
ac_add_options --enable-update-channel=release
ac_add_options --with-distribution-id=org.archlinux
ac_add_options --with-unsigned-addon-scopes=app,system
ac_add_options --allow-addon-sideload
export MOZILLA_OFFICIAL=1
export MOZ_APP_REMOTINGNAME=${isim//-/}
ac_add_options MOZ_SERVICES_METRICS=
ac_add_options MOZ_PAY=
ac_add_options MOZ_SERVICES_HEALTHREPORTER=
ac_add_options MOZ_SERVICES_FXACCOUNTS=
ac_add_options MOZ_SERVICES_METRICS=
ac_add_options MOZ_DATA_REPORTING=
ac_add_options MOZ_DEVICES=
ac_add_options MOZ_REQUIRE_SIGNING=
ac_add_options MOZ_TELEMETRY_REPORTING=

# Keys
ac_add_options --with-google-location-service-api-keyfile=${PWD@Q}/google-api-key
ac_add_options --with-google-safebrowsing-api-keyfile=${PWD@Q}/google-api-key
ac_add_options --with-mozilla-api-keyfile=${PWD@Q}/mozilla-api-key

# Features
ac_add_options --enable-alsa
ac_add_options --enable-jack
ac_add_options --enable-startup-notification
ac_add_options --enable-crashreporter
ac_add_options --disable-gconf
ac_add_options --disable-updater
ac_add_options --disable-tests
ac_add_options --enable-install-strip
ac_add_options --enable-strip
END

mkdir -p third_party/rust/libloading/.deps
export LDFLAGS+=" -Wl,-rpath=/usr/lib/firefox"
export MOZ_NOSPAM=1
export MOZBUILD_STATE_PATH="$SRC/mozbuild"
export MOZ_MAKE_FLAGS="${MAKEJOBS}"

rm -f old-configure
SHELL=/bin/bash ./mach build
