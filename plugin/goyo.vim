Plugin 'junegunn/goyo.vim', { 'type': 'opt' }

autocmd vimrc User GoyoEnter nested call plugin#goyo#enter()
autocmd vimrc User GoyoLeave nested call plugin#goyo#leave()

nmap <expr> <Leader>gy exists('#goyo')
      \ ? ':Goyo!<cr>'
      \ : ':packadd goyo.vim <bar> Goyo<cr>'
