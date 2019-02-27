" Vim syntax file & snippets for Dockerfile
Plugin 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

" since the docker ftplugin looks for Docker.* and sets it to a docker file
" i need to reassure vim that this is a vim file
autocmd FileType Dockerfile.vim set ft=vim
