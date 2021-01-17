_toolver=447
cd clojure-tools

install -Dm644 deps.edn "${PKG}/usr/share/clojure/deps.edn"
install -Dm644 example-deps.edn "${PKG}/usr/share/clojure/example-deps.edn"
install -Dm644 clojure-tools-${surum}.$_toolver.jar "${PKG}/usr/share/clojure/libexec/clojure-tools-${surum}.$_toolver.jar"
install -Dm755 clojure "${PKG}/usr/bin/clojure"
install -Dm755 clj "${PKG}/usr/bin/clj"
install -Dm644 clojure.1 "${PKG}/usr/share/man/man1/clojure.1"
install -Dm644 clj.1 "${PKG}/usr/share/man/man1/clj.1"
install -Dm755 "${SRC}/clojure.sh" "${PKG}/etc/profile.d/clojure.sh"
