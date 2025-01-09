colorscheme slate
syntax enable
set relativenumber
set shiftwidth=4
set expandtab
set tabstop=4
set number

"filetype plugin indent on
"set cindent

command! RunCpp w !g++ -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! RunC w !gcc -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r

nnoremap n :NERDTree<CR>
nnoremap , 10j<CR>
nnoremap . 10k<CR>
nnoremap <C-s> :w<CR>
nmap <C-q> :q<CR>

call plug#begin('~/.vim/NVIM/')

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ycm-core/YouCompleteMe'
    Plug 'tpope/vim-commentary'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'preservim/nerdtree'

call plug#end()

let g:ycm_confirm_extra_conf = 0
