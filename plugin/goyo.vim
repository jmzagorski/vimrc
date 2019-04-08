Plugin 'junegunn/goyo.vim', { 'on': ['Goyo'] }

autocmd vimrc User GoyoEnter nested call plugin#goyo#enter()
autocmd vimrc User GoyoLeave nested call plugin#goyo#leave()
map <expr> <Leader>gy exists('#goyo') ? ":Goyo!<cr>" : ":Goyo<cr>"
