" Identation
set autoindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
filetype plugin indent on

" Search
set hlsearch
set ignorecase
set incsearch
set smartcase

" Performance
set complete-=i
set lazyredraw

" Text rendering
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1
set sidescrolloff=5
syntax enable
set wrap
set breakindent
set showbreak=⤿\ \ \ 

" User interface
set laststatus=2
set ruler
set wildmenu
set tabpagemax=50
set cursorline
set number
set relativenumber
set noerrorbells
set visualbell
set title
set background=dark
" unprintable characters
set listchars=space:·,eol:¶,trail:~,extends:>,precedes:<,tab:>->

" Code folding
set foldmethod=indent
set foldnestmax=3
set nofoldenable

" Miscellaneous
set autoread
set backspace=indent,eol,start
set hidden
set history=1000
set nrformats-=octal

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" ======== vim-plug ========
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
call plug#end()


" ======== easy-align ========
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ======== vim-code-dark ========
colorscheme codedark
let g:airline_theme = 'codedark'

