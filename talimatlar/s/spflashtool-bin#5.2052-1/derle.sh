gendesk -f -n \
		--pkgname "spflashtool" \
		--pkgdesc "Telefonlara yazılım atma aracı" \
		--name "SP Flash Tool" \
		--genericname "Firmware Flasher" \
		--comment "MediaTek (MTK) Firmware Flasher" \
		--exec "/usr/bin/spflashtool" \
		--categories "System;"

	# Create exec file. Required for the binary to find its own .so files
	{
		echo '#!/bin/sh'
		echo 'export LD_LIBRARY_PATH="/opt/'"spflashtool"'"'
		echo '/opt/'"spflashtool"'/flash_tool "${@}"'
	} > "${SRC}/spflashtool"
