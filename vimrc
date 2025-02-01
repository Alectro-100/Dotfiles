colorscheme sorbet
syntax enable
set relativenumber
set termguicolors
set shiftwidth=4
set expandtab
set tabstop=4
set number
filetype plugin indent on

command! RunCPP w !g++ --std=c++20 -fno-elide-constructors -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! RunC w !gcc -fno-elide-constructos -Wall -Wextra -O0 % -o %:r && ./%:r && rm ./%:r
command! InstallPlug call InstallPlug()

function! InstallPlug()
    call system("curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
endfunction

nnoremap <silent><A-j> :move +1 <CR>==
vnoremap <silent><A-j> :move '>+1 <CR>gv=gv
inoremap <silent><A-j> <ESC>:move +1 <CR>==gi

nnoremap <silent><A-k> :move -2 <CR>
xnoremap <silent><A-k> :move '<-2 <CR>gv=gv
inoremap <silent><A-k> <ESC>:move -2 <CR>==gi

nnoremap <silent><S-CR> <CMD>normal! o <CR>
nnoremap <silent><C-S-CR> <CMD>normal! O <CR>
nnoremap <silent><C-Space> <CMD>NERDTreeToggle<CR>
cnoremap <silent><C-CR> <INS><CR><ESC>

call plug#begin('~/.vim/VIM/')
    Plug 'tpope/vim-commentary'
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    " Plug 'tomsar/molokai'
call plug#end()

