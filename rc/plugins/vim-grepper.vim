" use your favorite grep tool
Plugin 'mhinz/vim-grepper'

" by default ignore case
command! -nargs=+ Rg :GrepperRg -i <args>
command! Todo :Rg "todo|fixme"
