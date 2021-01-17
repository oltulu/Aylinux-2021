	for DB_VER in 4.5 4.4 4.3 4.2 4.1.2
	do
		mkdir -p $PKG/usr/share/xml/docbook/xml-dtd-$DB_VER
		cp -a $SRC/$isim-$DB_VER/{ent,docbook.cat,*.dtd,*.mod} \
			$PKG/usr/share/xml/docbook/xml-dtd-$DB_VER/
	done
# create initial docbook-xml catalog
	mkdir -p $PKG/etc/xml
	xmlcatalog --noout --create $PKG/etc/xml/$isim

	# add each version to the initial catalog
	#
	# 4.5
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/calstblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/soextblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/dbpoolx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/dbhierx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/htmltblx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/dbnotx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/dbcentx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/dbgenent.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.5" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.5" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5" \
		$PKG/etc/xml/$isim
	# 4.4
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/docbookx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook CALS Table Model V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/calstblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML HTML Tables V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/htmltblx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/soextblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook Information Pool V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/dbpoolx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook Document Hierarchy V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/dbhierx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook Additional General Entities V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/dbgenent.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook Notations V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/dbnotx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook Character Entities V4.4//EN" \
		"http://www.oasis-open.org/docbook/xml/4.4/dbcentx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.4" \
		"file:///usr/share/xml/docbook/xml-dtd-4.4" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.4" \
		"file:///usr/share/xml/docbook/xml-dtd-4.4" \
		$PKG/etc/xml/$isim
	# 4.3
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML V4.3//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook CALS Table Model V4.3//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/calstblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/soextblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook Information Pool V4.3//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/dbpoolx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook Document Hierarchy V4.3//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/dbhierx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook Additional General Entities V4.3//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/dbgenent.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook Notations V4.3//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/dbnotx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook Character Entities V4.3//EN" \
		"http://www.oasis-open.org/docbook/xml/4.3/dbcentx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.3" \
		"file:///usr/share/xml/docbook/xml-dtd-4.3" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.3" \
		"file:///usr/share/xml/docbook/xml-dtd-4.3" \
		$PKG/etc/xml/$isim
	# 4.2
	xmlcatalog --noout --add "public" \
		"-//OASIS/DTD DocBook XML V4.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS/DTD DocBook CALS Table Model V4.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/calstblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS/DTD XML Exchange Table Model 19990315//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/soextblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS/ELEMENTS DocBook Information Pool V4.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/dbpoolx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS/ELEMENTS DocBook Document Hierarchy V4.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/dbhierx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS/ENTITIES DocBook Additional General Entities V4.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/dbgenent.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS/ENTITIES DocBook Notations V4.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/dbnotx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS/ENTITIES DocBook Character Entities V4.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.2/dbcentx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.2" \
		"file:///usr/share/xml/docbook/xml-dtd-4.2" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.2" \
		"file:///usr/share/xml/docbook/xml-dtd-4.2" \
		$PKG/etc/xml/$isim
	# 4.1.2
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML V4.1.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML CALS Table Model V4.1.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/calstblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/soextblx.dtd" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Information Pool V4.1.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/dbpoolx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.1.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/dbhierx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Additional General Entities V4.1.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/dbgenent.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Notations V4.1.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/dbnotx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Character Entities V4.1.2//EN" \
		"http://www.oasis-open.org/docbook/xml/4.1.2/dbcentx.mod" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.1.2" \
		"file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
		$PKG/etc/xml/$isim
	xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.1.2" \
		"file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
		$PKG/etc/xml/$isim
        
        