" Enable Colorscheme
colorscheme habamax

" Basic Vim settings
set number                       " Show line numbers
set relativenumber               " Show relative line numbers
set expandtab                    " Convert tabs to spaces
set tabstop=2                    " Number of spaces that a tab counts for
set shiftwidth=2                 " Number of spaces for indentation
set softtabstop=2                " Make backspace behave correctly
set smartindent                  " Smart auto-indenting
set autoindent                   " Enable auto-indenting
set wrap                         " Wrap long lines
"set clipboard=unnamedplus       " Use system clipboard
set mouse=a                      " Enable mouse support

" Syntax highlighting and auto-completion
syntax on                        " Enable syntax highlighting
filetype plugin indent on        " Enable filetype detection and indentation
set completeopt=menu,menuone,noselect " Better autocompletion experience

" Search settings
set ignorecase                   " Case insensitive searching
set smartcase                    " Case sensitive when search pattern includes uppercase

" Interface improvements
set cursorline                   " Highlight current line
set showcmd                      " Show (partial) command in the last line
set wildmenu                     " Enhanced command-line completion
set lazyredraw                   " Don't redraw while executing macros
set showmatch                    " Show matching brackets
set incsearch                    " Incremental search
set hlsearch                     " Highlight search results

filetype plugin indent on        " Enable auto-indentation

call plug#begin()

" List your plugins here
 Plug 'tpope/vim-sensible'
 Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
 Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}

call plug#end()
