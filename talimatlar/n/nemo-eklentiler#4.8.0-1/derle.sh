paketler = (nemo-fileroller nemo-image-converter nemo-preview nemo-python nemo-share nemo-terminal)

cd "${SRC}"/nemo-extensions-${surum}
sed -i '/^GNOME_/d' nemo-image-converter/configure.ac

    for _dir in "${paketler[@]}"; do
        if ! [[ -f ${_dir}/configure.ac || -f ${_dir}/configure.in ]]; then
            continue
        fi
        pushd ${_dir}
        autoreconf -fi
        popd
    done
    
    for _dir in "${paketler[@]}"; do
        if [[ -f ${_dir}/configure ]]; then
            pushd ${_dir}
            ./configure --prefix=/usr \
                        --sysconfdir=/etc \
                        --localstatedir=/var \
                        --libexecdir=/usr/lib/${_dir} \
                        --disable-schemas-compile
            sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0 /g' \
                   -e 's/    if test "$export_dynamic" = yes && test -n "$export_dynamic_flag_spec"; then/      func_append compile_command " -Wl,-O1,--as-needed"\n      func_append finalize_command " -Wl,-O1,--as-needed"\n\0/' libtool
            make
            popd
        elif [[ -f ${_dir}/meson.build ]]; then
            mkdir -p ${_dir}/builddir
            pushd ${_dir}/builddir
            meson --prefix=/usr \
                  --libexecdir=lib/${_dir} \
                  --buildtype=plain \
                  ..
            samu
            popd
        fi
    done