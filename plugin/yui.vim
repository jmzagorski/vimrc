Plugin 'cideM/yui'

augroup MyColors
  autocmd!
  autocmd ColorScheme yui highlight Label gui=italic cterm=italic
  autocmd ColorScheme yui highlight ColorColumn ctermbg=lightgrey guibg=#cccccc
augroup END

colorscheme yui
