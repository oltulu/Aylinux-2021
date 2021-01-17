    for DB_VER in 4.5 4.4 4.3 4.2
	do
		mkdir $SRC/$isim-$DB_VER
		unzip -q -d $SRC/$isim-$DB_VER /sources/$isim-$DB_VER.zip
	done
	# now 4.1.2, named differently
	mkdir $SRC/$isim-4.1.2
	unzip -q -d $SRC/$isim-4.1.2 /sources/docbkx412.zip
