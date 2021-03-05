for i in 16x16 24x24 32x32 48x48 64x64 128x128 256x256; do
		install -Dm644 "$PKG"/opt/google/chrome/product_logo_${i/x*/}.png \
			"$PKG"/usr/share/icons/hicolor/$i/apps/google-chrome.png
	done


	sed -i \
		-e "/Exec=/i\StartupWMClass=Google-chrome" \
		-e "s/x-scheme-handler\/ftp;\?//g" \
		"$PKG"/usr/share/applications/google-chrome.desktop

	rm -r "$PKG"/etc/cron.daily/ "$PKG"/opt/google/chrome/cron/
	rm "$PKG"/opt/google/chrome/product_logo_*.png
