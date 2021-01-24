#!/bin/sh
# build lua statically

# server
cd server
./build.sh
cd ..

# client
cd client
./build.sh
cd ..

# terminal user interface
cd tui
cd minisock && make && mv -v *.so ../ && cd ..
cd lnewt && make && mv -v *.so ../ && cd ..
cd ..

# copy initscript of ayguci-server
cd aux
install -v -m755 ayguci /etc/rc.d/init.d/ayguci
cd ..

# copy desktop file of ayguci-gui
cd gui
install -v -m644 ayguci.desktop /usr/share/applications/ayguci.desktop
install -v -m644 com.milis.pkexec.ayguci.policy /usr/share/polkit-1/actions/com.milis.pkexec.ayguci.policy
chmod +x ayguci-gui.py
cd ..
