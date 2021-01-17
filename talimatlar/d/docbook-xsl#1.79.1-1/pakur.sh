install -v -m 0755 -d $PKG/usr/share/xml/docbook/xsl-stylesheets-$surum

	cp -v -R \
		VERSION common eclipse epub extensions fo \
		highlighting html htmlhelp images javahelp lib manpages \
		params profiling roundtrip slides template tests tools website \
		xhtml xhtml-1_1 \
		$PKG/usr/share/xml/docbook/xsl-stylesheets-$surum

	ln -s VERSION $PKG/usr/share/xml/docbook/xsl-stylesheets-${surum}/VERSION.xsl

	ln -sf xsl-stylesheets-$surum $PKG/usr/share/xml/docbook/xsl-stylesheets

	install -v -m 0644 -D README \
		$PKG/usr/share/doc/docbook-xsl-$surum/README.txt

	install -v -m 0755 RELEASE-NOTES* NEWS* \
		$PKG/usr/share/doc/docbook-xsl-$surum
        