function! s:hook(hooktype, name)
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

Plugin 'danielwe/base16-vim', {'type': 'opt', 'do': {-> function('s:hook')}}
" Plugin 'chriskempson/base16-vim', {'type': 'opt', 'do': {-> function('s:hook')}}

if filereadable(expand("~/.vimrc_background"))
  "per the docs only enable this if the ~/.cofig/base16/colortest does not show blue for 17-21
  let base16colorspace=256
  source ~/.vimrc_background
  :packadd base16-vim
  autocmd vimrc ColorScheme * call s:base16_customize()
endif

function! s:base16_customize() abort
  call Base16hi("SpellBad", "", "", g:base16_cterm08, g:base16_cterm00, "", "")
  call Base16hi("SpellCap", "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
  call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
  call Base16hi("SpellRare", "", "", g:base16_cterm0B, g:base16_cterm00, "", "")
  hi SpellBad cterm=underline
endfunction

