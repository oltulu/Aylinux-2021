if [ ! -z "$(getent group cgred)" ]; then
	/usr/bin/groupdel -r cgred
fi
