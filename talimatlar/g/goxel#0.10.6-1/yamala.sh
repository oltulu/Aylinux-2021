 sed -i 's|scons mode=release|scons mode=release werror=n|
          s|/share/applications/goxel.desktop|/share/applications/io.github.guillaumechereau.Goxel.desktop|
          s|install -Dm744 goxel|install -Dm755 goxel|' Makefile
 sed -i 's|\${SNAP}/icon.png|goxel|' snap/gui/goxel.desktop
