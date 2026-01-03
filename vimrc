" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

" Settings ------------------------------ {{{settings
" XDG support {{{
if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

" fallback locations if no XDG
if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME."/.cache"       | endif
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME."/.config"      | endif
if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME."/.local/share" | endif
if empty($XDG_STATE_HOME)  | let $XDG_STATE_HOME  = $HOME."/.local/state" | endif

" some useful directories as env vars
let $MY_VIM_TMP_DIR = $XDG_STATE_HOME."/vim/tmp"
let $MY_VIM_DATA_DIR = $XDG_DATA_HOME."/vim"
let $MY_VIM_CONFIG_DIR = $XDG_CONFIG_HOME."/vim"
let $MY_VIM_STATE_DIR = $XDG_STATE_HOME."/vim"

" set runtimepath
set runtimepath^=$MY_VIM_CONFIG_DIR
set runtimepath+=$MY_VIM_DATA_DIR
set runtimepath+=$MY_VIM_CONFIG_DIR/after

" Fix. Set directory for a custom build of vim inside /usr/local space
set packpath^=/usr/local/share/vim/vim91
" set directory for Vim8 build-in packages
set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

let g:netrw_home = $MY_VIM_STATE_DIR
let g:coc_config_home = $MY_VIM_CONFIG_DIR
call mkdir($MY_VIM_DATA_DIR."/spell", 'p', 0700)

set backupdir=$MY_VIM_TMP_DIR/backup// | call mkdir(&backupdir, 'p', 0700)
set directory=$MY_VIM_TMP_DIR/swap//   | call mkdir(&directory, 'p', 0700)
set undodir=$MY_VIM_TMP_DIR/undo//     | call mkdir(&undodir,   'p', 0700)
set viewdir=$MY_VIM_TMP_DIR/view//     | call mkdir(&viewdir,   'p', 0700)

set backupskip+=$MY_VIM_TMP_DIR/*

if !has('nvim') " Neovim has its own special location
  set viminfofile=$MY_VIM_STATE_DIR/viminfo
endif
" }}}

" Identation ---------------------------- {{{
set autoindent
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
filetype plugin indent on
" }}}

" Search -------------------------------- {{{
set hlsearch
set ignorecase
set incsearch
set smartcase
" }}}

" Performance --------------------------- {{{
set complete-=i
set lazyredraw
" }}}

" Text rendering ------------------------ {{{
set display+=lastline
set encoding=utf-8
set linebreak
set scrolloff=1
set sidescrolloff=5
syntax enable
set wrap
set breakindent
set showbreak=⤿\ \ \ 
set textwidth=0
set colorcolumn=81,121
" }}}

" User interface ------------------------ {{{
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
set listchars=space:·,eol:¶,trail:·,extends:>,precedes:<,tab:>-> " unprintable characters
set nosplitbelow " new window split directions
set splitright
set cmdheight=2 " more space for messages
" }}}

" Code folding --------------------------- {{{
set foldmethod=indent
set foldnestmax=3
set nofoldenable
" }}}

" Miscellaneous -------------------------- {{{
set autoread
set backspace=indent,eol,start
set hidden
set history=1000
set nrformats-=octal
set modelines=0 " disable modelines for security
set nomodeline
set path=.,,** " look for file dir, then current dir, then any current subdir for files
" }}}

set backup
set writebackup
set undofile
" }}}
" settings}}}

" Default mapping ----------------------------------- {{{
let mapleader = ","
let maplocalleader = "\\"
inoremap jk <Esc>
" disable defaults to train a better habit
" the following <Esc> for insert mode is buggy, breaks arrows and insertion (at least).
" TODO remove it when the habit of using jk is developed strong.
" inoremap <Esc> <Esc>:echo "\<Esc\> in INSERT mode has been disabled to develope a good habit. Use jk instead."<CR>a
inoremap <Left> <Esc>:echo "\<Left\> in INSERT mode has been disabled to develope a good habit. Instead, exit INSERT mode and move."<CR>a
inoremap <Right> <Esc>:echo "\<Right\> in INSERT mode has been disabled to develope a good habit. Instead, exit INSERT mode and move."<CR>a
inoremap <Up> <Esc>:echo "\<Up\> in INSERT mode has been disabled to develope a good habit. Instead, exit INSERT mode and move."<CR>a
inoremap <Down> <Esc>:echo "\<Down\> in INSERT mode has been disabled to develope a good habit. Instead, exit INSERT mode and move."<CR>a
nnoremap <Left> :echo "\<Left\> in NORMAL mode has been disabled to develope a good habit. Use h instead."<CR>
nnoremap <Right> :echo "\<Right\> in NORMAL mode has been disabled to develope a good habit. Use l instead."<CR>
nnoremap <Up> :echo "\<Up\> in NORMAL mode has been disabled to develope a good habit. Use k instead."<CR>
nnoremap <Down> :echo "\<Down\> in NORMAL mode has been disabled to develope a good habit. Use j instead."<CR>

" open and apply vimrc configuration
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

" File browsing (netrw) ------------------------------ {{{
" Load netrw before configuring it (actual for modern vim, as became optional)
packadd! netrw
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}

" Vimscript file settings ---------------------------- {{{
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" Install vim-plug if not found ---------------------- {{{

if empty(glob($MY_VIM_DATA_DIR.'/autoload/plug.vim'))
  silent !curl -fLo $MY_VIM_DATA_DIR/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" }}}

" Run PlugInstall if there are missing plugins ------- {{{
augroup vim_plug_install_missing
  autocmd!
  autocmd VimEnter *
    \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \|   PlugInstall --sync | source $MYVIMRC
    \| endif
augroup END
" }}}

" vim-plug plugins ----------------------------------- {{{
call plug#begin(expand($MY_VIM_DATA_DIR.'/plugged'))
Plug 'tpope/vim-sensible'
Plug 'guns/xterm-color-table.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tomtom/tcomment_vim'
Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-surround'
" disable auto-pairs as it highjacks some Copilot mappings
" Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'kevinoid/vim-jsonc'
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Github Copilot
Plug 'github/copilot.vim'

" plain text accounting 
Plug 'ledger/vim-ledger'

call plug#end()
" }}}

" Plugins settings ------------------------ {{{plugins
" Plugin copilot.vim --------------------- {{{
inoremap <C-[> <Plug>(copilot-dismiss)
inoremap <C-]> <Plug>(copilot-next)
" Plugin easy-align ----------------------- {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

" Plugin vim-rainbow ---------------------- {{{
let g:rainbow_active = 1
" }}}

" Plugin coc.nvim ------------------------- {{{
let g:coc_global_extensions = ['coc-json']
if isdirectory('./node_modules') && isdirectory('./node_modules/typescript')
  let g:coc_global_extensions += ['coc-tsserver']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" show docs on K
nnoremap <silent> K :call CocAction('doHover')<CR>
" Perform code action
nmap <leader>do <Plug>(coc-codeaction)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
" Format current buffer.
nmap <leader>ff <Plug>(coc-format)
" Show all diagnostics.
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p :<C-u>CocListResume<CR>"

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

augroup my_coc
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END
" }}}
" plugins}}}

" Theme vim-code-dark ---------------------- {{{
colorscheme codedark
let g:airline_theme = 'codedark'
" }}}

" Terminal cursor color and shape ---------- {{{
if &term =~ "xterm\\|rxvt"
  " 1 or 0 -> blinking block
  " 2 -> solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar

  " cursor color for Insert Mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " cursor shape for Inser Mode
  let &t_SI .= "\<Esc>[5 q"
  " cursor color otherwise
  let &t_EI = "\<Esc>]12;white\x7"
  " cursor shape otherwise
  let &t_EI .= "\<Esc>[2 q"
  " reset cursor color on exit
  autocmd VimLeave * silent !echo -ne "\x1b]12;white\x7"
  " reset cursor shape on exit
  autocmd VimLeave * silent !echo -ne "\x1b[\x30 q"
endif
" }}}

