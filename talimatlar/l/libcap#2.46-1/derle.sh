sed -i "/SBINDIR/s#sbin#bin#" Make.Rules
sed -i "s/CFLAGS :=/CFLAGS += \$(CPPFLAGS) /" Make.Rules
sed -i "s/LDFLAGS :=/LDFLAGS +=/" Make.Rules
make -C $SRC/libcap-$surum KERNEL_HEADERS=/usr/include
