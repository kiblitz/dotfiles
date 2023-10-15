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
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
" ## added by OPAM user-setup for vim / ocp-indent ## 10fce2f0f480a00736a992004061dd5b ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/gelos/.opam/4.14.0/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
