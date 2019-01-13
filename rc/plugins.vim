" Load all the plugins automatically on startup
" DO NOT NAME THE ~/.vim/plugin, dein does not like it
if &compatible
 set nocompatible
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if has('win32') || has('win64')
  set runtimepath+=$MYVIMRCPATH/rc
else
  set runtimepath+=$MYVIMRCPATH/rc/plugins/
endif

call dein#begin('$HOME/.cache/dein')

call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

"" FIXME: bug
if has('win32') || has('win64')
  runtime! plugins/*.vim
else
  runtime! rc/plugins/*.vim
endif

call dein#end()

filetype plugin indent on
syntax enable

runtime macros/matchit.vim
