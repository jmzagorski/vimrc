Plugin 'nightsense/snow'

set termguicolors

" snowy nigh
if strftime('%H') >= 7 && strftime('%H') < 19
  set background=light
else
  set background=dark
endif
colorscheme snow
