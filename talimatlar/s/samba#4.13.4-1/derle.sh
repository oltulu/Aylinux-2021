sed -r 's/nss_(setpw|endpw|setgr|endgr)ent/my_&/' \
    -i nsswitch/nsstest.c

echo "^samba4.rpc.echo.*on.*ncacn_np.*with.*object.*nt4_dc" >> selftest/knownfail


./configure                             \
    --prefix=/usr                       \
    --sysconfdir=/etc                   \
    --localstatedir=/var                \
    --with-piddir=/run/samba            \
    --with-pammodulesdir=/lib/security  \
    --without-ad-dc                     \
    --enable-fhs                        \
    --bundled-libraries=!tdb            \
                    --without-{ad-dc,ads,ldap} \
                --without-json  \
    --enable-selftest

make
