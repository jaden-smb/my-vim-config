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
noremap <leader>g :Rg<cr>  
noremap <leader>d :call ToggleNERDTreeWithRefresh()<cr>
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
Plug 'lewis6991/gitsigns.nvim'    " Git signs in the gutter
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
Plug 'mustache/vim-mustache-handlebars'  
Plug 'othree/html5.vim'                  
Plug 'hail2u/vim-css3-syntax'            
Plug 'groenewege/vim-less'               
Plug 'ap/vim-css-color'                  
Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' }

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "html", 
    "css", 
    "javascript"
    -- Handlebars parser not available
  },
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  }
}

-- Configure gitsigns
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 1000,
  },
  update_debounce = 100,
  status_formatter = nil,
  diff_opts = {
    internal = true
  }
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

" File type associations
autocmd BufNewFile,BufRead *.hbs,*.handlebars setfiletype html.handlebars
autocmd BufNewFile,BufRead *.less setfiletype less

" Emmet settings for HTML and CSS
let g:user_emmet_install_global = 0
autocmd FileType html,css,handlebars EmmetInstall
let g:user_emmet_leader_key='<C-e>'

" Auto close tags for HTML, Handlebars
let g:closetag_filenames = '*.html,*.hbs,*.handlebars'

" Prettier configuration
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_path = "~/.npm-global/bin/prettier"

" Add custom filetypes to auto-close tags
let g:closetag_filetypes = 'html,xhtml,phtml,handlebars,hbs'

" Tab settings for HTML, CSS, LESS and JS
autocmd FileType html,css,less,javascript,handlebars setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Enable syntax highlighting for LESS
autocmd BufNewFile,BufRead *.less set filetype=less

colorscheme jellybeans

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" CoC Configuration (replace existing section)
let g:coc_start_at_startup = 1
let g:coc_global_extensions = [ 
  \ 'coc-tsserver',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-prettier'
  \ ]

" Increase timeout for CoC language server initialization
let g:coc_service_startup_timeout = 30000
let g:coc_default_semantic_highlight_groups = 1

" Custom CoC initialization logic
function! CocSetup() abort
  " Defer CoC completion until server is ready
  let g:coc_disable_startup_warning = 1
  
  " Add buffer-specific CoC commands
  autocmd FileType javascript,typescript,html,css,less,handlebars
    \ command! -nargs=0 Format :call CocAction('format')
endfunction

" Wait for language servers to be ready before enabling features
function! CheckLanguageServerStatus(timer_id)
  " Check if CoC is ready
  if exists('g:coc_service_initialized') && g:coc_service_initialized == 1
    " Enable language server features only after initialization
    call coc#config('languageserver.html.initializationOptions.embeddedLanguages.css', v:true)
    call coc#config('languageserver.html.initializationOptions.embeddedLanguages.javascript', v:true)
  endif
endfunction

" Special handling for Handlebars files
function! SetupHandlebarsEnv() abort
  " Force filetype to handlebars only (not html.handlebars)
  set filetype=handlebars
  
  " Temporarily disable diagnostics while the server initializes
  call coc#config('diagnostic.enable', v:false)
  
  " Explicitly refresh the language server for this buffer
  call timer_start(500, {-> execute('CocCommand workspace.showOutput handlebars')})
  
  " Wait a bit before enabling diagnostics to ensure server is ready
  call timer_start(5000, {-> coc#config('diagnostic.enable', v:true)})
  
  " Force refresh the buffer after language server is initialized
  call timer_start(5500, {-> execute('edit')})
endfunction

" Initialize CoC only after vim has fully started
autocmd VimEnter * call CocSetup()

" Special handling for Handlebars files with longer initialization delay
autocmd BufNewFile,BufRead *.hbs,*.handlebars call SetupHandlebarsEnv()

" Start a timer to check language server status after startup with increased timeout
autocmd VimEnter * call timer_start(3000, 'CheckLanguageServerStatus', {'repeat': 6})

" Add key binding to manually restart CoC server if needed
nmap <leader>cr :CocRestart<CR>

" Set color scheme after CoC is loaded to avoid errors
autocmd User CocNvimInit colorscheme jellybeans

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
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['^\.DS_Store$', '^\.git$', '^node_modules$']
let g:NERDTreeStatusline = ''
let g:NERDTreeQuitOnOpen=1

" Function to robustly toggle NERDTree and fix common display issues
function! ToggleNERDTreeWithRefresh()
  if exists('g:NERDTree') && g:NERDTree.IsOpen()
    " If NERDTree is already open, close it
    NERDTreeClose
  else
    " If we have a file open, open NERDTree at that file's location and select it
    if expand('%:p') != ''
      NERDTreeFind
    else
      " If no file is open, just open NERDTree in the current directory
      NERDTree
    endif
  endif
endfunction

" Fix NERDTree when directory is not displayed
function! NERDTreeRefreshRoot()
  if exists("g:NERDTree") && g:NERDTree.IsOpen()
    NERDTreeClose
    " Wait briefly and reopen with current working directory
    sleep 100m
    NERDTree %:p:h
    " Return to the previous window
    wincmd p
  else
    " If NERDTree isn't open, open it with current file's directory
    NERDTree %:p:h
    " Return to the previous window
    wincmd p
  endif
endfunction

" Map ,r to refresh/fix NERDTree
noremap <leader>r :call NERDTreeRefreshRoot()<CR>

" Git keybindings with vim-fugitive
nnoremap <leader>gs :Git<CR>                " git status
nnoremap <leader>gc :Git commit<CR>         " git commit
nnoremap <leader>gd :Gdiff<CR>              " git diff
nnoremap <leader>gb :Git blame<CR>          " git blame
nnoremap <leader>gl :Git log<CR>            " git log
nnoremap <leader>gp :Git push<CR>           " git push
nnoremap <leader>gf :Git fetch<CR>          " git fetch
nnoremap <leader>gpl :Git pull<CR>          " git pull

" Gitsigns navigation and actions
nnoremap ]h :Gitsigns next_hunk<CR>         " Navigate to next hunk
nnoremap [h :Gitsigns prev_hunk<CR>         " Navigate to previous hunk
nnoremap <leader>hp :Gitsigns preview_hunk<CR>     " Preview hunk
nnoremap <leader>hs :Gitsigns stage_hunk<CR>       " Stage hunk
nnoremap <leader>hu :Gitsigns undo_stage_hunk<CR>  " Undo stage hunk
nnoremap <leader>hr :Gitsigns reset_hunk<CR>       " Reset hunk
nnoremap <leader>hb :Gitsigns toggle_current_line_blame<CR> " Toggle blame for current line
