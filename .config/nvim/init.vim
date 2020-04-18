let mapleader=" "

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
nnoremap <leader>c :e $MYVIMRC<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<cr>/<C-R>=@/<cr><cr>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<cr>?<C-R>=@/<cr><cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

command! SudoEdit e suda://%
command! SudoWrite w suda://%

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
vnoremap <C-c> "*ygv"+y
vnoremap <C-x> "*d

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

command! DeleteCurrentFile call delete(@%)|bd!
command! TrimWhitespace %s/\s\+$//e
command! RemoveExtraWhitespace %s/ \{2,}/ /g

"auto-reload
autocmd! BufWritePost $MYVIMRC source %
autocmd! BufWritePost .zshrc silent! execute "!source %"
autocmd! BufWritePost .compton.conf silent! execute "!pkill compton;compton &"
autocmd! BufWritePost sxhkdrc silent! execute "!pkill sxhkd;sxhkd &"
autocmd! BufWritePost .spectrwm.conf silent! execute "!pkill -HUP spectrwm &"

"emoji 😏
let g:emoji_complete_overwrite_standard_keymaps = 0
imap <C-E> <Plug>(emoji-start-complete)

"colorscheme
let g:one_allow_italics=1
let g:airline_theme='one'
set background=light
set termguicolors

"let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'

"c#
let g:ale_linters={
    \ 'cs': ['OmniSharp']
    \}
let g:ale_sign_error = '❗'
let g:ale_sign_warning = '⚠️'
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:omnicomplete_fetch_full_documentation = 1
sign define OmniSharpCodeActions text=💡

augroup OSCountCodeActions
  autocmd!
  autocmd FileType cs set signcolumn=yes
  autocmd CursorHold *.cs call OSCountCodeActions()
augroup END

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> <F12> :OmniSharpGotoDefinition<cr>
    "uses quickfix window: https://stackoverflow.com/a/1747286
    autocmd FileType cs nnoremap <buffer> <S-F12> :OmniSharpFindUsages<cr>
    autocmd FileType cs nnoremap <buffer> <leader>t :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <buffer> [e :ALEPreviousWrap<cr>
    autocmd FileType cs nnoremap <buffer> ]e :ALENextWrap<cr>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <leader>. :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
xnoremap <leader>. :call OmniSharp#GetCodeActions('visual')<cr>

nnoremap <F2> :OmniSharpRename<cr>

"haskell
let g:haskell_enable_quantification=1
let g:haskell_enable_pattern_synonyms=1
let g:haskell_indent_disable=1

set completefunc=LanguageClient#complete
set splitbelow
"lsp
function! LSP_maps()
    if has_key(g:LanguageClient_serverCommands, &filetype)
        nnoremap <F12> :call LanguageClient#textDocument_definition()<cr>
        nnoremap <F9> :call LanguageClient#textDocument_references()<cr>
        nnoremap <leader>r :call LanguageClient#textDocument_rename()<cr>
        nnoremap <leader>. :call LanguageClient_contextMenu()<cr>

        augroup lsp_commands
            autocmd!
            autocmd CursorHold *
                \ call LanguageClient#textDocument_hover()
                \ | call LanguageClient#textDocument_documentHighlight()
            "autocmd CursorHoldI * call LanguageClient#textDocument_completion()
        augroup END
    endif
endfunction
autocmd FileType * call LSP_maps()

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
Plug 'vifm/vifm.vim'
Plug 'lambdalisue/suda.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-obsession'
Plug '907th/vim-auto-save'
Plug 'kyuhi/vim-emoji-complete'
Plug 'rakr/vim-one'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'dense-analysis/ale'
Plug 'OmniSharp/omnisharp-vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'vmchale/dhall-vim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set noswapfile

set number
set shortmess=atI
set listchars=tab:▸\ ,eol:¬
set list
"set autochdir "might break plugins?
set completeopt=longest,menuone,preview
set updatetime=200
set diffopt+=vertical

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

" For search
set ignorecase smartcase

" Highlight search results
set hlsearch incsearch

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
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab

" Linebreak on 500 characters
set linebreak textwidth=500

set autoindent smartindent nowrap "Don't wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

function! OSCountCodeActions() abort
  if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
  if !OmniSharp#IsServerRunning() | return | endif
  let opts = {
  \ 'CallbackCount': function('s:CBReturnCount'),
  \ 'CallbackCleanup': {-> execute('sign unplace 99')}
  \}
  call OmniSharp#CountCodeActions(opts)
endfunction

function! s:CBReturnCount(count) abort
  if a:count
    let l = getpos('.')[1]
    let f = expand('%:p')
    execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
  endif
endfunction

colorscheme one
