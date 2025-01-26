Plugin 'cideM/yui'

augroup MyColors
  let &t_Cs = "\e[4:3m"
  let &t_Ce = "\e[4:0m"
  autocmd!
  autocmd ColorScheme yui highlight Label gui=italic cterm=italic
  autocmd ColorScheme yui highlight ColorColumn ctermbg=lightgrey guibg=#cccccc
augroup END

colorscheme yui
