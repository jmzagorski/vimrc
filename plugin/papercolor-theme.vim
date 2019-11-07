Plugin 'NLKNguyen/papercolor-theme'

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if strftime('%H') >= 7 && strftime('%H') < 19
  set background=light
else
  set background=dark
endif

colorscheme PaperColor
