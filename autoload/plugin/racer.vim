function! plugin#racer#post_install(hooktype, name)
  if !executable('cargo')
    echohl WarningMsg
    echom 'Skipping vim-racer installation. cargo is not installed'
    echohl None
    finish
  endif

  if !executable('rustup')
    echohl WarningMsg
    echom 'Skipping vim-racer installation. rustup is not installed'
    echohl None
    finish
  endif

  silent !clear
  execute '!rustup toolchain add nightly'
  execute '!cargo +nightly install racer'
  execute '!rustup component add rust-src'

  if !empty($RUST_SRC_PATH)
    finish
  endif

  if !executable('rustc')
    echohl WarningMsg
    echom 'Skipping vim-racer installation. rustc is not installed'
    echohl None
    finish
  endif

  let s:rust_root = system('rustc --print sysroot')
  let s:rust_src_path = substitute(s:rust_root, '\n', '', '') . '/lib/rustlib/src/rust/src'

  if has('win32')
    execute '!setx RUST_SRC_PATH ' . s:rust_src_path
  else
    execute printf('echo "export RUST_SRC_PATH=%s" >> ~/.profile', s:rust_src_path)
  endif

  echom "Please restart your terminal since RUST_SRC_PATH"
endfunction
