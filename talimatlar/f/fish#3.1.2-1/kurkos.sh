grep -qe '^/usr/bin/fish$' /etc/shells || echo '/usr/bin/fish' >> /etc/shells
grep -qe '^/bin/fish$' /etc/shells || echo '/bin/fish' >> /etc/shells
