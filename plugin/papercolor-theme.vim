Plugin 'NLKNguyen/papercolor-theme'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

try
  colorscheme PaperColor
catch /^Vim\%((\a\+)\)\=:E185/
  echohl ErrorMsg
  silent! echoerr "PaperColor theme not found. This usually happens with a fresh install of vim. Run PackInstall to get it."
  echom v:errmsg | redraw!
  echoh1 None
endtry

setglobal background=light
