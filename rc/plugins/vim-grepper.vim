" use your favorite grep tool
Plugin 'mhinz/vim-grepper'

command! Todo :GrepperRg TODO\ \|\ FIXME
" by default ignore case
command! -nargs=+ Rg :GrepperRg -i <args>
