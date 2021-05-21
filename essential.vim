" No packages
" vim -u essential.vim
"
set nocompatible
filetype plugin on
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


" Key mappings
nnoremap <silent> <C-l> :nohl<CR><C-l>
let mapleader = "\<Space>"
" Save file in edit mode
inoremap <c-s> <Esc>:update<CR>
" Save file in normal mode
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

" Buffers navigation
" page 85, tip 37
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" also
nnoremap <leader><leader> <c-^>
nnoremap <c-t> <c-^>

" Run python script
" from https://stackoverflow.com/questions/18948491/running-python-code-in-vim
" :!python % , or send all lines from buffer to python
" or, q: - and search last command
autocmd FileType python nnoremap <buffer> <leader>5 :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

"colorscheme zellner
colorscheme industry

"au Filetype tex set colorcolumn=80
au Filetype tex set textwidth=80
