" https://github.com/sdaschner/dotfiles/blob/master/.vimrc

packadd limelight.vim
packadd goyo.vim

setlocal syntax=markdown
setlocal showbreak=\ \ \ 
setlocal nospell

" presentation mode
nmap <F5> :setlocal relativenumber! number! showmode! showcmd! hidden! ruler! colorcolumn=0<CR>
nmap <F3> :call FindExecuteCommand()<CR>

" jump to slides
if executable('toilet')
  nmap <leader>B :read !toilet -w 200 -f smblock<CR>
  nmap <leader>F :read !toilet -w 200 -f standard<CR>
  nmap <leader>f :read !toilet -w 200 -f small<CR>
  nmap <leader>1 :read !toilet -w 200 -f term -F border<CR>
endif

iabbrev - ⁃
iabbrev -V ✓

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

if filereadable("syntax.vim")
  source syntax.vim
elseif filereadable("../syntax.vim")
  source ../syntax.vim
endif
