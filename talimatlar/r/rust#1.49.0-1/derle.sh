 cd "rustc-$surum-src"

  cat >config.toml <<END
[llvm]
link-shared = true
[build]
target = ["x86_64-unknown-linux-gnu", "i686-unknown-linux-gnu", "x86_64-unknown-linux-musl"]
tools = ["cargo", "rls", "clippy", "miri", "rustfmt", "analysis", "src"]
cargo = "/usr/bin/cargo"
rustc = "/usr/bin/rustc"
python = "/usr/bin/python"
extended = true
sanitizers = false
profiler = true
vendor = true
[install]
prefix = "/usr"
[rust]
# LLVM crashes when passing an object through ThinLTO twice.  This is triggered
# when using rust code in cross-language LTO if libstd was built using ThinLTO.
# http://blog.llvm.org/2019/09/closing-gap-cross-language-lto-between.html
# https://github.com/rust-lang/rust/issues/54872
codegen-units-std = 1
debuginfo-level-std = 2
channel = "stable"
rpath = false
[target.x86_64-unknown-linux-gnu]
llvm-config = "/usr/bin/llvm-config"
[target.x86_64-unknown-linux-musl]
musl-root = "/usr/lib/musl"
END

export RUST_BACKTRACE=1
  export RUST_COMPILER_RT_ROOT="$SRC/compiler-rt-11.0.0.src"

  python ./x.py dist -j "$(nproc)"
  DESTDIR="$PWD"/dest-rust python ./x.py install -j "$(nproc)"

  # Remove analysis data for libs that weren't installed
  # TODO: Find out where these come from
  local file lib
  while read -rd '' file; do
    lib="${file%.json}.rlib"
    lib="${lib/\/analysis\///lib/}"
    if [[ ! -e $lib ]]; then
      echo "missing '$lib'"
      rm -v "$file"
    fi
  done < <(find "dest-rust/usr/lib/rustlib"  -path '*/analysis/*.json' -print0)

  # move docs and cross targets out of the way for splitting
  mv dest-rust/usr/lib/rustlib/i686-unknown-linux-gnu dest-i686
  mv dest-rust/usr/lib/rustlib/x86_64-unknown-linux-musl dest-musl
  mv dest-rust/usr/share/doc dest-doc
  
