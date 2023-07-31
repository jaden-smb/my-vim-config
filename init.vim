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

nnoremap <C-Z> u
nnoremap <C-Y> <C-R>

inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>

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
Plug 'm4xshen/autoclose.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'yaegassy/coc-typescript-vue-plugin', {'do': 'yarn install --frozen-lockfile'}
Plug 'windwp/nvim-ts-autotag'

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
EOF



inoremap <buffer> > ></<C-x><C-o><C-y><C-o>%<CR><C-o>O

let g:vim_vue_plugin_config = { 
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['javascript'],
      \   'style': ['css'],
      \},
      \'full_syntax': [],
      \'initial_indent': [],
      \'attribute': 0,
      \'keyword': 0,
      \'foldexpr': 0,
      \'debug': 0,
      \}

colorscheme jellybeans

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:coc_global_extensions = [ 'coc-tsserver' ]

let g:airline_powerline_fonts = 1

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Terminal exit mapping
:tnoremap <Esc> <C-\><C-n>
" Open terminal mapping

:imap ii <Esc>
" Terraform config
let g:terraform_fmt_on_save=1
" NERDTreeConfig
let g:NERDTreeQuitOnOpen=1
