" No packages: vim -u essential.vim
set nocompatible
filetype plugin indent on
syntax on
set encoding=utf-8
set wrap
set linebreak
set relativenumber
set number
set spell
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set mouse=a " Enable mouse usage (all modes) in terminals
set autochdir
set autoread

let mapleader = "\<Space>"
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Save file in edit mode
inoremap <c-s> <Esc>:update<CR>
" Save file in normal mode
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
" Buffers navigation: page 85, tip 37
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Switch buffers
nnoremap <leader><leader> <c-^>
nnoremap <c-t> <c-^>

" :!python % - send all lines from buffer to python
autocmd FileType python nnoremap <buffer> <leader>5 :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
" p.257, tip 103 
nnoremap <leader>t :!ctags -R --exclude=.git<CR>

" ========== COLORS ========== "
"colorscheme zellner
colorscheme industry

"au Filetype tex set colorcolumn=80
au Filetype tex set textwidth=80
