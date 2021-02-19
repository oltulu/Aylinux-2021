cd $SRC

configure_args=(
 -Dpolkit_agent=true
 -Dsystemd_journal=false
 -Dlibaudit=no
 -Dovs=false
 -Dlibnm_glib=true
 -Dselinux=false
 -Dmodify_system=true
 -Dsystemdsystemunitdir=no
 -Dsuspend_resume=consolekit
 -Dpppd=/usr/bin/pppd
 -Dqt=false
 -Dconcheck=false
 -Dpppd_plugin_dir=/usr/lib/pppd/2.4.7
 -Dresolvconf=/usr/bin/resolvconf
 -Ddhclient=/usr/bin/dhclient
 -Dkernel_firmware_dir=/usr/lib/firmware
 -Ddnsmasq=/usr/bin/dnsmasq
 -Ddbus_conf_dir=/usr/share/dbus-1/system.d
 -Dudev_dir=/usr/lib/udev
 -Dintrospection=true
 -Diwd=true
 -Dvapi=true
 -Ddocs=false
 -Dtests=no
 -Dmore_asserts=no
 -Dmore_logging=false
 -Dsession_tracking=no
 -Dsession_tracking_consolekit=false
)

milis-meson NetworkManager-$surum build "${configure_args[@]}"

ninja -C build
