"NEEDS RUST NIGHTLY, MIGHT WANT TO WAIT

call dein#add('racer-rust/racer', {'build': 'cargo +nightly install racer'})

"otherwise you need to save the current buffer every time you do a goto-definition
set hidden
let g:racer_cmd = "$HOME/.cargo/bin/racer"
