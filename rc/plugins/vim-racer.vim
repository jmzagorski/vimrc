call dein#add('racer-rust/vim-racer', {'build': 'cargo +nightly build --release && rustup component add rust-src' })

let $RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
