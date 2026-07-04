" ========================
" Basic Settings
" ========================
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set termguicolors
syntax on
filetype plugin indent on

" ========================
" UI & Navigation
" ========================
set number
set relativenumber
set cursorline
set showcmd
set ruler
set laststatus=2
set wildmenu
set scrolloff=5
set showmatch
set splitbelow splitright
set title

" ========================
" Tabs & Indentation
" ========================
set shiftwidth=4
set tabstop=4

" ========================
" Searching
" ========================
set ignorecase
set incsearch
set hlsearch
nnoremap <silent> <leader><space> :nohlsearch<CR>

" ========================
" Leader & Keybinds
" ========================
let mapleader=" "
nnoremap <leader>w :w<CR>
nnoremap <leader>q :wq<CR>
nnoremap <leader>c :q!<CR>
nnoremap <leader>e :NERDTreeFind<CR>
nnoremap <leader>v :topleft vnew<CR>:NERDTree<CR>

nnoremap <leader>t :sh<CR>
nnoremap <leader>n :tabe <C-R>=input('New file: ')<CR><CR>

" ========================
" Window management
" ========================
" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize windows with Ctrl + Arrow keys
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

nnoremap <Tab>  :tabn <CR>
nnoremap <S-Tab> :tabp<CR>


" ========================
" Clipboard integration
" ========================
set clipboard=unnamedplus " Use system clipboard by default

" ========================
" Undo & Backup
" ========================
set undofile
set undodir=~/.vim/undo

" ========================
" Plugins (vim-plug)
" ========================
" Install vim-plug if missing:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'morhetz/gruvbox'
" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" File explorer
Plug 'preservim/nerdtree'
" Commenting
Plug 'tpope/vim-commentary'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Git integration
Plug 'tpope/vim-fugitive'
" Surround text editing
Plug 'tpope/vim-surround'
" Auto pairs for brackets
Plug 'jiangmiao/auto-pairs'
" Syntax highlighting improvements
Plug 'sheerun/vim-polyglot'

call plug#end()

" ========================
" Colors
" ========================
set background=dark
colorscheme gruvbox

inoremap { {}<Esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

function! SmartEnter()
    let l:line = getline('.')
    let l:col = col('.') - 1

    " only trigger if previous char is {
	if l:col > 0 && l:line[l:col - 1] == '{' && l:line[l:col] == '}'
        return "\<CR>\<CR>\<Up>\<Tab>"
    endif

    return "\<CR>"
endfunction

function! SmartBackspace()
    let l:line = getline('.')
    let l:col = col('.')

    " cursor between paired quotes
    if l:col > 1 && l:col <= len(l:line)
        let l:left  = l:line[l:col - 2]
        let l:right = l:line[l:col - 1]

        if (l:left == "'" && l:right == "'") ||
         \ (l:left == '"' && l:right == '"') ||
         \ (l:left == '`' && l:right == '`') ||
         \ (l:left == '(' && l:right == ')') ||
         \ (l:left == '[' && l:right == ']') ||
         \ (l:left == '{' && l:right == '}')

            return "\<BS>\<Del>"
        endif
    endif

    return "\<BS>"
endfunction

inoremap <expr> <BS> SmartBackspace()
inoremap <expr> <CR> SmartEnter()
