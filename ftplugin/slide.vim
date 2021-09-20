" https://github.com/sdaschner/dotfiles/blob/master/.vimrc

packadd limelight.vim
packadd goyo.vim

setlocal showbreak=\ \ \ 

" presentation mode
nmap <F5> :setlocal relativenumber! number! showmode! showcmd! hidden! ruler! colorcolumn=0<CR>
nmap <F3> :call FindExecuteCommand()<CR>

" jump to slides
if executable('toilet')
  nmap <leader>F :.!toilet -w 200 -f standard<CR>
  nmap <leader>f :.!toilet -w 200 -f small<CR>
  nmap <leader>1 :.!toilet -w 200 -f term -F border<CR>
endif

iabbrev * •
iabbrev - ⁃
iabbrev -V ✓

" TODO put in autoload

function! JumpLastBuffer()
  execute "buffer " . len(Buffers())
endfunction

let g:presentationBoundsDisplayed = 0

function! FindExecuteCommand()
  let line = search('\S*!'.'!:.*')
  if line > 0
    let command = substitute(getline(line), "\S*!"."!:*", "", "")
    execute "silent !". command
    execute "normal gg0"
    redraw
  endif
endfunction
