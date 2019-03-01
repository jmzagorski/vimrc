Plugin 'danielwe/base16-vim', { 'type': 'opt', 'do': {-> function('plugin#base16#post_install')} }
" Plugin 'chriskempson/base16-vim', {'type': 'opt', 'do': {-> function('s:hook')}}

if filereadable(expand("~/.vimrc_background"))
  "per the docs only enable this if the ~/.cofig/base16/colortest does not show blue for 17-21
  try
    packadd base16-vim
    let base16colorspace=256
    source ~/.vimrc_background

    function! s:base16_customize() abort
      call Base16hi("SpellBad", "", "", g:base16_cterm08, g:base16_cterm00, "", "")
      call Base16hi("SpellCap", "", "", g:base16_cterm0A, g:base16_cterm00, "", "")
      call Base16hi("SpellLocal", "", "", g:base16_cterm0D, g:base16_cterm00, "", "")
      call Base16hi("SpellRare", "", "", g:base16_cterm0B, g:base16_cterm00, "", "")
      hi SpellBad cterm=underline
    endfunction

    autocmd vimrc ColorScheme * call s:base16_customize()
  catch e
    echohl WarningMsg
    echom '~/.vimrc_background found, but base16 colors is not downloaded.
          \ Check to make sure it is downloaded'
    echohl None
  endtry
endif
