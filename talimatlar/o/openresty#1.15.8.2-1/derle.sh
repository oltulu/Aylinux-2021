_cfgdir=/opt/openresty/nginx/conf

./configure \
    --prefix=/opt/openresty \
    --conf-path=$_cfgdir/nginx.conf \
    --user=http --group=http \
    --with-file-aio \
    --with-http_dav_module \
    --with-http_gzip_static_module \
    --with-http_realip_module \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-luajit \
    --with-pcre-jit \
    --with-http_v2_module \
    --with-stream \
    --with-stream_ssl_module \
    --with-http_iconv_module
make
