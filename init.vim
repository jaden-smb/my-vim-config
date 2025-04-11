" =============================================================================
" ===                          BASIC SETTINGS                             ===
" =============================================================================
set number                      " Show line numbers
set relativenumber              " Show relative line numbers
set autoindent                  " Auto-indent new lines
set tabstop=4                   " Number of spaces a tab counts for
set shiftwidth=4                " Number of spaces for each step of indent
set smarttab                    " Smart handling of tab key
set softtabstop=4               " Number of spaces a tab counts for when editing
set mouse=a                     " Enable mouse support
set encoding=utf-8              " Use UTF-8 encoding
set clipboard+=unnamedplus      " Use system clipboard
set background=dark             " For better contrast with transparency
syntax on                       " Enable syntax highlighting

" Set termguicolors for better color support in terminals that support it
if has('termguicolors')
  set termguicolors
endif

" =============================================================================
" ===                         VIM-PLUG SETUP                              ===
" =============================================================================
" Auto-install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" =============================================================================
" ===                         KEY MAPPINGS                               ===
" =============================================================================
let mapleader = ","             " Set leader key to comma

" Basic operations
noremap <leader>w :w<cr>        " Save file
inoremap ii <Esc>               " Map ii to Escape in insert mode

" Folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Plugin operations
noremap <leader>s :CocSearch 
noremap <leader>f :Files<cr>
noremap <leader>g :Rg<cr>  
noremap <leader>d :call ToggleNERDTreeWithRefresh()<cr>
noremap <leader><cr> <cr><c-w>h:q<cr>

" Terminal mappings
noremap <leader>tv :botright vnew <Bar> :terminal<cr>
noremap <leader>th :botright new <Bar> :terminal<cr>
:tnoremap <Esc> <C-\><C-n>      " Exit terminal mode with Esc

" Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Undo/Redo in various modes
nnoremap <C-Z> u
nnoremap <C-Y> <C-R>
inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>
inoremap <c-z> <c-o>:u<CR>

" Auto-pairing for brackets and quotes
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" =============================================================================
" ===                         PLUGINS LIST                                ===
" =============================================================================
call plug#begin('~/.vim/plugged')

" --- Code completion and language support ---
Plug 'neoclide/coc.nvim', { 'tag': '*', 'branch' : 'release' }
Plug 'yaegassy/coc-typescript-vue-plugin', {'do': 'yarn install --frozen-lockfile'}

" --- Language syntax support ---
Plug 'pangloss/vim-javascript'           " JavaScript support
Plug 'leafgarland/typescript-vim'        " TypeScript syntax
Plug 'posva/vim-vue'                     " Vue.js support
Plug 'leafOfTree/vim-vue-plugin'         " Additional Vue.js support
Plug 'mustache/vim-mustache-handlebars'  " Handlebars support
Plug 'othree/html5.vim'                  " HTML5 support
Plug 'hail2u/vim-css3-syntax'            " CSS3 syntax
Plug 'groenewege/vim-less'               " LESS support
Plug 'ap/vim-css-color'                  " Color preview in CSS
Plug 'sheerun/vim-polyglot'              " Language pack collection

" --- Developer tools ---
Plug 'mattn/emmet-vim'                   " HTML/CSS expansion
Plug 'prettier/vim-prettier', { 'do': 'npm install --frozen-lockfile --production' }
Plug 'eslint/eslint'                     " JavaScript linting
Plug 'vim-syntastic/syntastic'           " Syntax checking
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'            " Auto-close HTML tags

" --- Git integration ---
Plug 'tpope/vim-fugitive'                " Git commands in Vim
Plug 'lewis6991/gitsigns.nvim'           " Git signs in the gutter

" --- Infrastructure as code ---
Plug 'hashivim/vim-terraform'            " Terraform support
Plug 'juliosueiras/vim-terraform-completion'

" --- UI and navigation ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                  " Fuzzy finder
Plug 'vim-airline/vim-airline'           " Status line
Plug 'preservim/nerdtree'                " File explorer
Plug 'ryanoasis/vim-devicons'            " File icons

" --- Code editing helpers ---
Plug 'tpope/vim-surround'                " Surround text objects
Plug 'alvan/vim-closetag'                " Auto-close HTML tags
Plug 'm4xshen/autoclose.nvim'            " Auto-close brackets

" --- Themes and appearance ---
Plug 'EdenEast/nightfox.nvim', { 'tag': 'v1.0.0' }
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'tribela/transparent.nvim'          " Transparent background
Plug 'rafamadriz/neon'                   " Neon color scheme

call plug#end()

" =============================================================================
" ===                     APPEARANCE AND TRANSPARENCY                      ===
" =============================================================================
lua << EOF
require('transparent').setup({
  extra_groups = {
    -- UI elements
    "NormalFloat", "StatusLine", "StatusLineNC", "VertSplit",
    "FloatBorder", "NonText", "SpecialKey", "Folded", "FoldColumn",
    "Pmenu", "CursorLine", "TabLine", "TabLineFill", "TabLineSel",
    
    -- Plugin specific elements
    "NvimTreeNormal", "TelescopeNormal", "WhichKeyFloat",
    
    -- Theme specific elements
    "NightfoxNormal", "NightfoxFloat", "NightfoxStatusLine"
  },
  exclude_groups = {},
  enable = true
})
EOF

" Function to ensure transparent highlights are applied after colorscheme changes
function! ApplyTransparentHighlights()
  " Define all UI elements that need transparent background
  let l:transparent_elements = [
    \ 'Normal', 'LineNr', 'SignColumn', 'EndOfBuffer', 
    \ 'NERDTreeNormal', 'StatusLine', 'StatusLineNC', 
    \ 'VertSplit', 'Folded', 'FloatBorder', 'Pmenu',
    \ 'CursorLine', 'TabLine', 'TabLineFill', 'TabLineSel'
  \ ]
  
  " Apply transparent background to all elements
  for element in l:transparent_elements
    execute 'hi ' . element . ' guibg=NONE ctermbg=NONE'
  endfor
  
  " Tell transparent.nvim to refresh
  if exists(':TransparentEnable')
    :TransparentEnable
  endif
endfunction

" Apply transparent background
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi NERDTreeNormal guibg=NONE ctermbg=NONE
hi StatusLine guibg=NONE ctermbg=NONE
hi StatusLineNC guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE ctermbg=NONE
hi Folded guibg=NONE ctermbg=NONE
hi FloatBorder guibg=NONE ctermbg=NONE
hi Pmenu guibg=NONE ctermbg=NONE

" =============================================================================
" ===                   TREESITTER AND GIT CONFIGURATION                  ===
" =============================================================================
lua <<EOF
-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "html", 
    "css", 
    "javascript"
    -- Handlebars parser not available
  },
  highlight = {
    enable = true,  -- Enable syntax highlighting
  },
  autotag = {
    enable = true,  -- Auto-close HTML/XML tags
  }
}

-- Git signs configuration
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,          -- Show signs in the sign column
  numhl = false,              -- Don't highlight line numbers
  linehl = false,             -- Don't highlight the whole line
  word_diff = false,          -- Don't show word diff
  watch_gitdir = {
    follow_files = true       -- Follow files when moved within repo
  },
  attach_to_untracked = true, -- Show signs for untracked files
  current_line_blame = false, -- Don't show blame for current line
  current_line_blame_opts = {
    virt_text = true,         -- Show blame as virtual text
    virt_text_pos = 'eol',    -- Position at end of line
    delay = 1000,             -- 1 second delay
  },
  update_debounce = 100,      -- Wait 100ms before updating
  status_formatter = nil,     -- Use default formatter
  diff_opts = {
    internal = true           -- Use internal diff library
  }
}
EOF

" =============================================================================
" ===                WEB DEVELOPMENT CONFIGURATION                        ===
" =============================================================================
" Auto tag completion for HTML
inoremap <buffer> > ></<C-x><C-o><C-y><C-o>%<CR><C-o>O

" Vue plugin configuration
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

" =============================================================================
" ===                FILETYPE-SPECIFIC SETTINGS                          ===
" =============================================================================
" File type associations
autocmd BufNewFile,BufRead *.hbs,*.handlebars setfiletype html.handlebars
autocmd BufNewFile,BufRead *.less setfiletype less

" Tab settings for web files (2 spaces)
autocmd FileType html,css,less,javascript,handlebars,vue setlocal tabstop=2 softtabstop=2 shiftwidth=2

" Emmet configuration
let g:user_emmet_install_global = 0
autocmd FileType html,css,handlebars,vue EmmetInstall
let g:user_emmet_leader_key='<C-e>'

" Auto close tags configuration
let g:closetag_filenames = '*.html,*.hbs,*.handlebars,*.vue'
let g:closetag_filetypes = 'html,xhtml,phtml,handlebars,hbs,vue'

" Prettier configuration
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#exec_cmd_path = "~/.npm-global/bin/prettier"

" =============================================================================
" ===                        THEME AND AIRLINE SETTINGS                   ===
" =============================================================================
" Configure Airline theme to work with transparency
let g:airline_theme='transparent'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" =============================================================================
" ===                        COC CONFIGURATION                           ===
" =============================================================================
" Basic CoC settings
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

" Set color scheme after CoC is loaded
autocmd User CocNvimInit colorscheme nightfox
autocmd User CocNvimInit call ApplyTransparentHighlights()

" =============================================================================
" ===                        COC CODE NAVIGATION                         ===
" =============================================================================
" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" =============================================================================
" ===                   INFRASTRUCTURE AS CODE SETTINGS                   ===
" =============================================================================
" Terraform configuration
let g:terraform_fmt_on_save=1

" =============================================================================
" ===                   NERDTREE CONFIGURATION                           ===
" =============================================================================
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
