Plugin 'justinmk/vim-dirvish'

"disable netrw (too buggy)
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>

cabbrev SHdo Shdo
let g:dirvish_relative_paths=1
