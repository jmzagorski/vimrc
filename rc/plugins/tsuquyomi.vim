Plugin 'Quramy/tsuquyomi', {'type': 'opt', 'for': 'typescript', 'do': {-> function('PostInstall_tsuquyomi')}}

function! PostInstall_tsuquyomi(hooktype, name)
  if isdirectory($HOME . './npm-packages') && executable('npm')
    execute '!npm i -g typescript'
  else
    echohl WarningMsg
    echom 'tsuquyomi requires typescript. You must download it manually'
    echohl None
  endif
endfunction

let g:tsuquyomi_disable_quickfix = 1

autocmd vimrc FileType typescript nnoremap <buffer> gd :TsuDefinition<CR>
