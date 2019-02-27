" use your favorite grep tool
Plugin 'mhinz/vim-grepper'

" by default ignore case
command! -nargs=+ Rg :GrepperRg <args>
command! Todo :Rg -i "todo|fixme"
