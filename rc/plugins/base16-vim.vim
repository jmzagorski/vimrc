call dein#add('chriskempson/base16-vim')

if !isdirectory($HOME . '/.config')
  silent !mkdir ~/.config
end
if !isdirectory($HOME . '/.config/base16-shell')
  silent !git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
end

if filereadable(expand("~/.vimrc_background"))
  "per the docs only enable this if the ~/.cofig/base16/colortest does not show blue for 17-21
  let base16colorspace=256
  source ~/.vimrc_background
endif
