sed -e 's/\$(MKSHLIB) -o/\$(MKSHLIB) \$(LDFLAGS) -o/g' -i nss/coreconf/rules.mk

export LIBRUNPATH=
export BUILD_OPT=1
export NSS_USE_SYSTEM_SQLITE=1
export NSS_ENABLE_WERROR=0
export NSS_ENABLE_ECC=1
export FREEBL_NO_DEPEND=1

_native_use64="USE_64=1"

cd nss
# Build nsinstall for host.
make ${_native_use64} -C coreconf


export NSPR_INCLUDE_DIR=/usr/include/nspr
export NSPR_LIB_DIR=/usr/lib
export XCFLAGS="${CFLAGS}"

make ${_native_use64} -C lib/dbm
make ${_native_use64}

