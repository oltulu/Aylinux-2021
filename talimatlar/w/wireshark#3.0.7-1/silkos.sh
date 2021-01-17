if [ ! -z "$(getent group wireshark)" ]; then
	/usr/bin/groupdel -r wireshark
fi
