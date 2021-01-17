if [ -z "$(getent group wireshark)" ]; then
	/usr/bin/groupadd -r wireshark
fi

chgrp wireshark /usr/bin/dumpcap
setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' /usr/bin/dumpcap
