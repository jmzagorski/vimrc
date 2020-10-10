function! plugin#editorconfig#post_install(hooktype, name) abort
  if !executable('editorconfig')
    echohl WarningMsg
    echom 'editorconfig-vim required editorconfig.'
    echohl None
  endif
endfunction
