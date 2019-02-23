function! s:hook(hooktype, name)
  if !executable('cargo')
    echom 'cargo is not installed, skipping vim-racer installation'
    finish
  endif

  if !executable('rustup')
    echom 'rustup is not installed, skipping vim-racer installation'
    finish
  endif

  let l:get_rust_nightly = '!rustup toolchain add nightly'
  let l:get_racer = '!cargo +nightly install racer'
  let l:get_rust_source = '!rustup component add rust-src'

  if has('job')
    " make sure we have the nighltly
    " first build racer
    job_start(l:get_rust_nightly)
    job_start(l:get_racer)
    job_start(l:get_rust_source)
  else
    silent !clear
    execute l:get_rust_nightly
    execute l:get_racer
    execute l:get_rust_source
  endif
endfunction

" this has ftplugin so it will lazy load
" it will not work with packadd
Plugin 'racer-rust/vim-racer', {'do': {-> function('s:hook')}}

silent let s:rust_root = system('rustc --print sysroot')
let $RUST_SRC_PATH = substitute(s:rust_root, '\n', '', '') . '/lib/rustlib/src/rust/src'

autocmd vimrc FileType rust nmap gd <Plug>(rust-def)
autocmd vimrc FileType rust nmap gs <Plug>(rust-def-split)
autocmd vimrc FileType rust nmap gx <Plug>(rust-def-vertical)
autocmd vimrc FileType rust nmap <leader>gd <Plug>(rust-doc)
