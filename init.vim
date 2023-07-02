set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set encoding=utf-8
syntax on
set clipboard+=unnamedplus

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Automatically save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"
let mapleader = ","
noremap <leader>w :w<cr>
noremap <leader>s :CocSearch 
noremap <leader>f :Files<cr>
noremap <leader>d :NERDTreeToggle<cr>
noremap <leader><cr> <cr><c-w>h:q<cr>
noremap <leader>tv :botright vnew <Bar> :terminal<cr>
noremap <leader>th :botright new <Bar> :terminal<cr>
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

inoremap <c-z> <c-o>:u<CR>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'hashivim/vim-terraform' " Terraform syntax and commands
Plug 'neoclide/coc.nvim' , { 'tag': '*', 'branch' : 'release' }
Plug 'vim-airline/vim-airline'
Plug 'eslint/eslint'
Plug 'preservim/nerdtree'
Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'EdenEast/nightfox.nvim', { 'tag': 'v1.0.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'mattn/emmet-vim'
Plug 'posva/vim-vue'
Plug 'alvan/vim-closetag'
Plug 'sheerun/vim-polyglot'

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

colorscheme jellybeans

let g:coc_global_extensions = [ 'coc-tsserver' ]

let g:airline_powerline_fonts = 1

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF

let g:coc_global_extensions = [ 'coc-tsserver' ]

let g:airline_powerline_fonts = 1
