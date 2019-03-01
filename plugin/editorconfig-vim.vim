" Requires external editorconfig
Plugin 'editorconfig/editorconfig-vim', { 'do': {-> function('plugin#editorconfig#post_install')} }

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'fugitive:\\\\.*']
