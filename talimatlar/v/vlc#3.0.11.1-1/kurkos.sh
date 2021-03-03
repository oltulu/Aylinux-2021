/usr/lib/vlc/vlc-cache-gen /usr/lib/vlc/plugins
cp /usr/bin/vlc /usr/bin/vlc-backup 
sed -i 's/geteuid/getppid/' /usr/bin/vlc
