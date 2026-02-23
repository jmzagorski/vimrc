Plugin 'tpope/vim-dotenv'

autocmd vimrc VimEnter * silent! Dotenv .
autocmd vimrc DirChanged * silent! Dotenv .
