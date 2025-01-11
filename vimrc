colorscheme molokai
syntax enable
set relativenumber
set shiftwidth=4
set expandtab
set tabstop=4
set number

command! RunCpp w !g++ -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! RunC w !gcc -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! InstallPlug call InstallPlug()

function! InstallPlug()
    call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
endfunction

nnoremap <silent><C-s> :w<CR>
nnoremap <silent><C-q> :q<CR>
inoremap <silent><C-q> <ESC>1k<CR>
nnoremap <silent><C-,> 10j<CR>
inoremap <silent><C-,> <ESC>10j<CR>
nnoremap <silent><C-.> 10k<CR>
inoremap <silent><C-.> <ESC>10k<CR>
nnoremap <silent><C-Space> :NERDTreeToggle<CR>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

call plug#begin('~/.vim/VIM/')

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-commentary'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'

call plug#end()

