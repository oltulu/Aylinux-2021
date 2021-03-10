install -Dm755 linux-boot-prober "$PKG"/usr/bin/linux-boot-prober
install -Dm755 os-prober "$PKG"/usr/bin/os-prober
install -Dm755 newns "$PKG"/usr/lib/os-prober/newns
install -Dm755 common.sh $PKG/usr/share/os-prober/common.sh

for dir in os-probes os-probes/mounted os-probes/init linux-boot-probes linux-boot-probes/mounted; do
	install -dm755 "$PKG/usr/lib/$dir"
	install -m755 -t "$PKG/usr/lib/$dir" "$dir"/common/*
	[[ -d "$dir"/x86 ]] && cp -r "$dir"/x86/* "$PKG/usr/lib/$dir"
done

install -Dm755 os-probes/mounted/powerpc/20macosx "$PKG"/usr/lib/os-probes/mounted/20macosx

install -dm755 "$PKG"/var/lib/os-prober
