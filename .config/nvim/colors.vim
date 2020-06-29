let &background=trim(system('cat ~/.cache/.bg'))
let g:one_wal_allow_italics=1
let g:airline_theme='one_wal'
set termguicolors
lua require'colorizer'.setup()
colorscheme one_wal
