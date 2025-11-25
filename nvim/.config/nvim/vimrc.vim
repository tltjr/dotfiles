" tltjr's neovim "vimrc"

" Basics
set backspace=start,indent,eol
set history=50
set laststatus=2
set showmode
set showcmd
set showmatch
set noerrorbells
set virtualedit=block
set title
set formatoptions=cqn1
set nofoldenable
set ignorecase
set ruler
set wildmenu
set clipboard=unnamed
set path+=include
set path+=lib
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set textwidth=78
set autoindent
set relativenumber
" Wiki support
set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on

map <Space> "_

command Tail setlocal autoread

"# format json
com! Fjson %!python3 -m json.tool

" vim-test
let test#strategy = "neovim"
let test#neovim#term_position = "vert botright"

