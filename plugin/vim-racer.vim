" XXX ftplugin does not work with packadd, or i am doing something wrong
Plugin 'racer-rust/vim-racer', {'type': 'opt', 'for': 'rust', 'do': {-> function('PostInstall_vim_racer')}}

function! PostInstall_vim_racer(hooktype, name)
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

autocmd vimrc FileType rust nmap gd <Plug>(rust-def)
autocmd vimrc FileType rust nmap gs <Plug>(rust-def-split)
autocmd vimrc FileType rust nmap gx <Plug>(rust-def-vertical)
autocmd vimrc FileType rust nmap <leader>gd <Plug>(rust-doc)
