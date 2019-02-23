" Requires external editorconfig
Plugin 'editorconfig/editorconfig-vim'

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

if !executable('editorconfig')
  echohl WarningMsg
  echom 'editorconfig-vim required editorconfig.'
  echohl None
endif
