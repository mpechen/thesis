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
nnoremap <silent> <C-l> :nohl<CR><C-l>
set mouse=a " Enable mouse usage (all modes) in terminals

" Key mappings
let mapleader = "\<Space>"
" Save file in edit mode
inoremap <c-s> <Esc>:update<CR>
" Save file in normal mode
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>

"colorscheme zellner
colorscheme industry

"au Filetype tex set colorcolumn=80
au Filetype tex set textwidth=80
