cachedir="build/cache/2020-06-04"
mkdir -p "$cachedir"

cp -f /sources/rust-std-1.44.0-x86_64-unknown-linux-gnu.tar.xz $cachedir/
cp -f /sources/rustc-1.44.0-x86_64-unknown-linux-gnu.tar.xz $cachedir/
cp -f /sources/cargo-0.45.0-x86_64-unknown-linux-gnu.tar.xz $cachedir/

# 'rust' checksums files in 'vendor/', but we patch a few.
for vendor in libc openssl-sys; do
    sed -i 's/\("files":{\)[^}]*/\1/' "vendor/$vendor/.cargo-checksum.json"
done

cat > config.toml <<EOF
[llvm]
link-shared = true

[build]
build  = "x86_64-unknown-linux-gnu"
host   = [ "x86_64-unknown-linux-gnu" ]
target = [ "x86_64-unknown-linux-gnu" ]
docs           = false
compiler-docs  = false
extended       = true
submodules     = false
python         = "python3"
locked-deps    = true
vendor         = true
sanitizers     = false
profiler       = false
full-bootstrap = false

[install]
prefix = "/usr"

[rust]
channel          = "stable"
rpath            = false
codegen-units    = 1
debuginfo-level  = 0
debug            = false
backtrace        = false
jemalloc         = false
debug-assertions = false
codegen-tests    = false

[target.x86_64-unknown-linux-gnu]
llvm-config = "/usr/bin/llvm-config"
crt-static  = false
EOF

LC_ALL=C python3 ./x.py build -j "$(nproc)"
