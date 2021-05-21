" basic
set encoding=utf8
set nowrap
" syntax on
set relativenumber
set number
" non-printable characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
let mapleader="\<SPACE>"
" copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy
" paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
" command to install plugin manager
command InstallVimPlug ! curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" plugins
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox' " gruvbox theme
Plug 'scrooloose/nerdtree' " gruvbox theme
call plug#end()
" gruvbox set up
set background=dark
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
" NERDTree
map <F2> :NERDTreeToggle<CR>
