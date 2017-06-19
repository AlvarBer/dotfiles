" Álvaro Bermejo .vimrc
" Minimal & functional

" Basics {{{
set nocompatible             " Where we are going we don't need vi

syntax enable                " Enable syntax processing

set encoding=utf8            " Set utf8 as standard encoding
" Ignored files
set wildignore+=*.o,*~,*.pyc,*/.git/*
"}}}

" Visuals {{{
" peachpuff, molokai, badwolf
colorscheme molokai          " Pretty good colouring

set number                   " Line numbers on the side
set scrolloff=7              " Always at least 7 vertical lines either side

set laststatus=2             " Show line with file being edited (And powerline)

set showmode                 " Show mode (Not needed with powerline)
set showcmd                  " Show last command
"set cursorline              " Highlight current line
set wildmenu                 " visual auto complete for command menu
set showmatch                " highlight matching [{()}]

set nowrap                   " Don't wrap text around
"}}}

" Indentation {{{
set tabstop=4                " Visual characters per hard tab
set shiftwidth=4             " 4 Characters per tab
"set softtabstop=4           " Consider 4 spaces a tab
"set smarttab                 " A <Tab> on a line inserts 'shiftwidth' blanks

set autoindent               " Needed for smartindent
set smartindent              " Expression-based indentation

filetype plugin indent on    " filetype specific indent and plugins
"}}}

" Key Mapping {{{
""" General
set mouse=                   " Disable mouse

let mapleader = "-"          " Leader key is the minus sign
let maplocalleader = "--"    " Local leader is twice the leader

""" Saving
" :W sudo saves the file
" (useful for handling the permission-denied error)
"command W w !sudo tee % > /dev/null

""" Movement
" Vertical move by visual line (and oh yeah, I use arrows)
nnoremap <up> gk
nnoremap <down> gj
" Move to beginning/end of line
noremap B ^
noremap E $
" Backspace is like other editors now
set backspace=indent,eol,start
set whichwrap+=<,>          " You can move down from the end of a line

""" Spelling
" Toggle Spell check with S, suggestions with s (:set spell spelllang=en_gb)
noremap S :set spell!<cr>
noremap s z=
" Add word with <leader>s
noremap <leader>s zg

""" Misc
" Turn off search highlight with space
nnoremap <leader><space> :nohlsearch<cr>
" Open NerdTree with q
noremap q :NERDTreeToggle<cr>
" Space open/closes folds
nnoremap <space> za
" z removes trailing space
nnoremap z :%s/\s\+$//e<cr> :write<cr>
" Z locates our cursor
nnoremap Z :set cursorline! cursorcolumn!<cr>
" $/^ won't do anything
noremap $ <nop>
noremap ^ <nop>
"}}}

" Search {{{
set incsearch                " Search as characters are entered
set hlsearch                 " Highlight matches
set ignorecase               " Ignore case when searching
set smartcase                " Pattern having upper-case won't ignore
set path+=**                 " Do recursive file search from current dir
set magic                    " Grep is more POSIX now
"}}}

" Folds {{{
set foldenable               " Enable folding
set foldlevelstart=10        " open most folds by default
set foldnestmax=10           " 10 nested fold max
set foldmethod=indent        " fold based on indent level
"}}}

" Persistence {{{
set viewoptions=folds,options,cursor

augroup AutoSaveFolds        " Save folds, options and cursor between sessions
	autocmd!
	autocmd BufWinLeave ?* mkview
	autocmd BufWinEnter ?* silent! loadview
augroup END

" Undo even after closing VIM
set undodir=~/.vim/undodir
set undofile
"}}}

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} " File browser
let NERDTreeIgnore = ['\.log', '\.aux', '\.pdf', '__pycache__']
Plug 'vim-airline/vim-airline' " Powerline
let g:airline_powerline_fonts = 1 " Powerline symbols
Plug 'vim-airline/vim-airline-themes' " Powerline themes
let g:airline_theme='powerlineish' " Powerlinish look
Plug 'vim-scripts/TagHighlight' " Tag highlighting
Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags' " Automatic Tags
let g:easy_tags_by_filetype=1 " Tags by filetype
let g:easy_tags_async = 1 " Asynchronous tagging
let g:easy_tags_events = ['BufReadPost', 'BufWritePost'] " Not working!
let g:easytags_suppress_report = 1 " Easytags talks too much

call plug#end()
"}}}

" Others {{{
set modeline                 " This allows us to set files for this
set modelines=1              " specific file
" Auto reload
"augroup reload_vimrc
"	autocmd!
"	autocmd BufWritePost ~/.vimrc source ~/.vimrc
"augroup END
"}}}

" vim:foldmethod=marker:foldlevel=0
