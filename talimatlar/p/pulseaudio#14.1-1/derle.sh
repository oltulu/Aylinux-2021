ekconf="-prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-oss-output --disable-oss-wrapper --disable-tcpwrap --with-pulsedsp-location='/usr/lib/pulseaudio'
 --enable-jack --disable-lirc --disable-hal-compat --disable-gconf --enable-orc
 --with-database=tdb --with-udev-rules-dir=/usr/lib/udev/rules.d --disable-bluez4
 --disable-esound --disable-gtk3 --enable-bluez5 --disable-bluez5-ofono-headset
 --disable-systemd-login --disable-systemd-daemon --disable-systemd-journal
 --enable-webrtc-aec --with-bash-completion-dir=/usr/share/bash-completion/completions
 --enable-bluez5-native-headset --disable-default-build-tests"

NOCONFIGURE=1 ./bootstrap.sh

./configure $confopt $ekconf
