CFLAGS="-march=${CARCH/_/-} -mtune=generic -O2 -pipe"
make
sed -i '/strncpy/s#sizeof(TEMPLATE)#sizeof(template)#' harness/cases/19.t
sed -i '/strncpy/s#sizeof(TEMPLATE)#sizeof(temp_file)#' harness/cases/21.t
make partcheck
