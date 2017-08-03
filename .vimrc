let mapleader = "\\"
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number		" show line numbers
set tabstop=4		" set number of spaces per tab
set shiftwidth=4	" set number of spaces per each (auto)indent
set autoindent		" copy indent from current line when creating a new line
set expandtab		" insert spaces instead of tab
set smarttab		" use shiftwidth instead of tabstop at beginning of line (redundant)
set softtabstop=4	" delete tabstop number of spaces when possible
set relativenumber  " show line numbers relative to current line

au BufRead,BufNewFile *.cf set ft=cf3
set foldmethod=indent
set foldlevel=99

set splitbelow
set splitright

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
filetype on
filetype plugin indent on
set hlsearch

filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets.git'
Bundle 'ivanov/vim-ipython'
Bundle 'ervandew/supertab'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary.git'
Bundle 'fatih/vim-go'
call vundle#end()

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_python_checkers=['flake8']

" Solarized
syntax enable
set background=dark
let g:solarized_termtrans = 1
let g:solarized_termcolors = 256
colorscheme solarized

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" rainbow_parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" nerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Easy window splits
map <C-w><Bar> <C-W>v<C-W><Right>
map <C-w>- <C-W>s<C-W><Down>

map <silent> <C-w>H <C-w>30< 
map <silent> <C-w>J <C-W>15- 
map <silent> <C-w>K <C-W>15+ 
map <silent> <C-w>L <C-w>30> 

" Hotkey for paste mode
set pastetoggle=<C-w>p

" Hotkey for line numbers
noremap <C-w>u :set nonumber!<CR>
