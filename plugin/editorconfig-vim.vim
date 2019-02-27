" Requires external editorconfig
Plugin 'editorconfig/editorconfig-vim', { 'do': {-> function('PostInstall_editorconfig_vim')} }

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

function! PostInstall_editorconfig_vim(hooktype, name)
  if !executable('editorconfig')
    echohl WarningMsg
    echom 'editorconfig-vim required editorconfig.'
    echohl None
  endif
endfunction
