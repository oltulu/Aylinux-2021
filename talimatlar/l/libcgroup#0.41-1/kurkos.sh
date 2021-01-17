if [ -z "$(getent group cgred)" ]; then
	/usr/bin/groupadd -r cgred
fi

chown root:cgred /usr/bin/cgexec
chmod g+s /usr/bin/cgexec
