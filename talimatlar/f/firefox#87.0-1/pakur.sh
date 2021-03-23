SHELL=/bin/bash DESTDIR="$PKG" ./mach install

cat > /tmp/zzz << "EOF"
// Use LANG environment variable to choose locale
pref("intl.locale.requested", "");

// Use system-provided dictionaries
pref("spellchecker.dictionary_path", "/usr/share/hunspell");

// Disable default browser checking.
pref("browser.shell.checkDefaultBrowser", false);

// Don't disable our bundled extensions in the application directory
pref("extensions.autoDisableScopes", 11);
pref("extensions.shownSelectionUI", true);
EOF
_vendorjs="$PKG/usr/lib/firefox/browser/defaults/preferences/vendor.js"
install -Dm644 /tmp/zzz "$_vendorjs" 

cat > /tmp/zzz << "EOF"
[Global]
id=aylinux
version=2.0
about=Aylinux için Mozilla Firefox 

[Preferences]
app.distributor=milislinux
app.distributor.channel=firefox
app.partner.aylinux=aylinux
EOF
_distini="$PKG/usr/lib/$isim/distribution/distribution.ini"
install -Dm644 /tmp/zzz "$_distini"

for i in 16 22 24 32 48 64 128 256; do
install -Dm644 browser/branding/official/default$i.png \
  "$PKG/usr/share/icons/hicolor/${i}x${i}/apps/$isim.png"
done
install -Dm644 browser/branding/official/content/about-logo.png \
"$PKG/usr/share/icons/hicolor/192x192/apps/$isim.png"
install -Dm644 browser/branding/official/content/about-logo@2x.png \
"$PKG/usr/share/icons/hicolor/384x384/apps/$isim.png"
install -Dvm644 browser/branding/official/content/identity-icons-brand.svg \
"$PKG/usr/share/icons/hicolor/symbolic/apps/$isim-symbolic.svg"

install -Dm644 ../$isim.desktop \
"$PKG/usr/share/applications/$isim.desktop"

# Install a wrapper to avoid confusion about binary path
cat > /tmp/zzz << "EOF"
#!/bin/sh
exec /usr/lib/firefox/firefox "$@"
EOF
install -Dm755 /tmp/zzz "$PKG/usr/bin/firefox"

# Replace duplicate binary with wrapper
# https://bugzilla.mozilla.org/show_bug.cgi?id=658850
ln -srf "$PKG/usr/bin/firefox" "$PKG/usr/lib/$isim/firefox-bin"

install -Dm644 $KAYNAK_DIZIN/firefox-tr-${surum}.xpi $PKG/usr/lib/firefox/browser/extensions/langpack-tr@firefox.mozilla.org.xpi

	install -d $PKG/etc/revdep.d
	echo "/usr/lib/firefox" > $PKG/etc/revdep.d/firefox
