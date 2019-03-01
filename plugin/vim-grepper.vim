" use your favorite grep tool
Plugin 'mhinz/vim-grepper', { 'on': [ 'Grepper' ] }

" by default ignore case
command! -nargs=+ Rg :GrepperRg <args>
command! Todo :Rg -i "todo|fixme"
