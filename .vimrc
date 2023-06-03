" Vundle configuration

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'ycm-core/YouCompleteMe'

Plugin 'preservim/nerdtree'

Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'

call vundle#end()
filetype plugin indent on

" airline
let g:airline#extensions#tabline#enabled = 1

" NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" gitgutter

" space tab industry standard
let g:python_recommended_style = 0

set tabstop=2
set expandtab

" auto indent in functions
set shiftwidth=2

" syntax highlighting
syntax on

" highlight word search and unhighlight on (\)
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap \ :noh<return>

" show matching parentheses / brackets
set showmatch

" toggle code folds with space
nnoremap <space> :call ToggleFolds()<CR>
set foldmethod=indent
set nofoldenable

" toggle function
let $foldOn=0
function ToggleFolds()
  if $foldOn==1
    :exe "normal zR"
    let $foldOn=0
  else
    :exe "normal zM"
    let $foldOn=1
  endif
endfunction

" no wrapped line skip
nmap j gj
nmap k gk

" memory configuration
set viminfo='100,<1000,s100,h

set mouse=a

" color scheme
color koehler
