call dein#add('chriskempson/base16-vim', {'build': 'git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell'})

if filereadable(expand("~/.vimrc_background"))
  "per the docs only enable this if the ~/.cofig/base16/colortest does not show blue for 17-21
  let base16colorspace=256
  source ~/.vimrc_background
endif
