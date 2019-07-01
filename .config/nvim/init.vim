let mapleader=" "

nnoremap do :echo "Use cc instead"<cr>

nnoremap Y y$
vnoremap P "0p
nnoremap <cr> o<Esc>
nnoremap <tab> <C-w><C-w>
nnoremap <silent> <leader>/ :nohlsearch<cr>
nnoremap <silent> <leader>so :source %<cr>:nohlsearch<cr>
nnoremap <silent> <leader>d :bd<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>o :only<cr>

noremap! <M-h> <left>
noremap! <M-j> <down>
noremap! <M-k> <up>
noremap! <M-l> <right>
noremap! <M-p> <backspace>
noremap! <M-x> <delete>

map <C-l> :bnext<cr>
map <C-h> :bprevious<cr>

"NERDcommenter
nmap <C-c> <nop>
nmap <C-k><C-c> yy<leader>cl
vmap <C-k><C-c> ygv<leader>cl
map <C-k><C-u> <leader>cu

"clipboard
inoremap <S-Ins> <C-o>"*p
nnoremap <S-Ins> "*p
vnoremap <S-Ins> x"*p
vnoremap <C-c> "*y
vnoremap <C-x> "*d

"abbreviations
abbrev Sth Seth
abbrev Steh Seth
abbrev Hlland Holland
abbrev Holand Holland

"auto-reload
autocmd! BufWritePost $MYVIMRC source %

"emoji 😏
let g:emoji_complete_overwrite_standard_keymaps = 0
imap <C-E> <Plug>(emoji-start-complete)

"Omnisharp
let g:ale_linters={
    \ 'cs': ['OmniSharp']
    \}
augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> <F12> :OmniSharpGotoDefinition<cr>
    "uses quickfix window: https://stackoverflow.com/a/1747286
    autocmd FileType cs nnoremap <buffer> <S-F12> :OmniSharpFindUsages<cr>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <leader>. :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
xnoremap <C-.> :call OmniSharp#GetCodeActions('visual')<cr>

nnoremap <F2> :OmniSharpRename<cr>

command! DeleteCurrentFile call delete(@%)|bd!
command! TrimWhitespace %s/\s\+$//e
command! RemoveExtraWhitespace %s/ \{2,}/ /g

set number
set shortmess=atI
set listchars=tab:▸\ ,eol:¬
set list
set autochdir "might break plugins?
set completeopt=longest,menuone,preview
set updatetime=1000
set diffopt+=vertical

"colorscheme mac_classic
let g:one_allow_italics=1
let g:airline_theme='one'
set background=light
set termguicolors

"let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'

"if !exists('g:airline_symbols')
"    let g:airline_symbols={}
"endif
"let g:airline_symbols.linenr='¶'

"ctrlp
let g:ctrlp_show_hidden=1
let g:ctrlp_custom_ignore={
    \ 'dir':  '\v[\/]\.(git|stack-work|node_modules|dist|tmp)$',
    \ 'file': '\v\.(exe|dll|zip)$'
    \ }
let g:ctrlp_match_window='bottom,order:btt,min:1,max:50,results:20'

"haskell
let g:haskell_enable_quantification=1
let g:haskell_enable_pattern_synonyms=1
let g:haskell_indent_disable=1

" Plugins
let g:plugautoload=expand('~/AppData/Local/nvim/autoload/plug.vim')
if has('unix')
  let g:plugautoload='~/.config/nvim/autoload/plug.vim'
endif

if empty(glob(g:plugautoload))
  silent execute '!curl -fLo ' . g:plugautoload . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'kshenoy/vim-signature'
Plug 'danro/rename.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-obsession'
Plug '907th/vim-auto-save'
Plug 'Konfekt/vim-alias'
Plug 'kyuhi/vim-emoji-complete'
Plug 'rakr/vim-one'
Plug 'w0rp/ale'
Plug 'OmniSharp/omnisharp-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'vmchale/dhall-vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Amir Salihefendic — @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Ignore case when completing files
set wildignorecase

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells novisualbell t_vb= tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use DOS as the standard file type
if has('unix')
    set ffs=unix,dos,mac
else
    set ffs=dos,unix,mac
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
"set nobackup
"set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" Be smart when using tabs ;)
set smarttab

" Linebreak on 500 characters
set linebreak textwidth=500

set autoindent
set smartindent
set nowrap "Don't wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<cr>/<C-R>=@/<cr><cr>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<cr>?<C-R>=@/<cr><cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab=1
nmap <leader>tl :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab=tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg=@"
    execute "normal! vgvy"

    let l:pattern=escape(@", "\\/.*'$^~[]")
    let l:pattern=substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/=l:pattern
    let @"=l:saved_reg
endfunction

colorscheme one
