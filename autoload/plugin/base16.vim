function! plugin#base16#post_install(hooktype, name)
  let config_dir = $HOME . '/.config'
  let git_dir = $HOME . '/.config'
  let color_file = $HOME . '/.vimrc_background'

  if !isdirectory(config_dir)
    silent !mkdir ~/.config
  end
  if !isdirectory(git_dir)
    silent !git clone https://github.com/chriskempson/base16-shell.git git_dir
  end
endfunction
