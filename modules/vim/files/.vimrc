set nowrap
set background=dark
set autoindent
set shiftwidth=2
set softtabstop=2
set tabstop=2 " show \t as 3 spaces and treat 2 spaces as \t when deleting, etc..
set expandtab
set ruler
syntax enable
syntax on

colorscheme vividchalk 

filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.
set cindent


if has("autocmd")
filetype indent on
endif
