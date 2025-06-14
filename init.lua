-- Basic Options
local opt = vim.opt
opt.number = true            -- Show line numbers
opt.relativenumber = true    -- Relative numbers
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.softtabstop = 4
opt.mouse = "a"
opt.encoding = "utf-8"
opt.clipboard:append("unnamedplus")
opt.background = "dark"
opt.termguicolors = true

-- Leader
vim.g.mapleader = ","

---------------------------------------------------------------------
-- Packer Bootstrap -------------------------------------------------
---------------------------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

---------------------------------------------------------------------
-- Plugins ----------------------------------------------------------
---------------------------------------------------------------------
require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })

  -- Code completion / LSP Front-end --------------------------------
  use({ "neoclide/coc.nvim", branch = "release" })
  use({ "yaegassy/coc-typescript-vue-plugin", run = "yarn install --frozen-lockfile" })

  -- Language & syntax ---------------------------------------------
  use("pangloss/vim-javascript")
  use("leafgarland/typescript-vim")
  use("posva/vim-vue")
  use("leafOfTree/vim-vue-plugin")
  use("mustache/vim-mustache-handlebars")
  use("othree/html5.vim")
  use("hail2u/vim-css3-syntax")
  use("groenewege/vim-less")
  use("ap/vim-css-color")
  use("sheerun/vim-polyglot")

  -- Developer helpers ---------------------------------------------
  use("mattn/emmet-vim")
  use({ "prettier/vim-prettier", run = "npm install --frozen-lockfile --production" })
  use("eslint/eslint")
  use("vim-syntastic/syntastic")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use("windwp/nvim-ts-autotag")

  -- Git ------------------------------------------------------------
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")

  -- Infrastructure as Code ----------------------------------------
  use("hashivim/vim-terraform")
  use("juliosueiras/vim-terraform-completion")

  -- UI & Navigation ------------------------------------------------
  use({ "junegunn/fzf", run = function() vim.fn["fzf#install"]() end })
  use("junegunn/fzf.vim")
  use("vim-airline/vim-airline")
  use("preservim/nerdtree")
  use("ryanoasis/vim-devicons")
  use("jistr/vim-nerdtree-tabs")

  -- Editing helpers ------------------------------------------------
  use("tpope/vim-surround")
  use("alvan/vim-closetag")
  use("m4xshen/autoclose.nvim")

  -- Appearance -----------------------------------------------------
  use({ "EdenEast/nightfox.nvim", tag = "v1.0.0" })
  use("rafi/awesome-vim-colorschemes")
  use("tribela/transparent.nvim")
  use("rafamadriz/neon")

  if packer_bootstrap then
    require("packer").sync()
  end
end)

---------------------------------------------------------------------
-- Plugin Config ----------------------------------------------------
---------------------------------------------------------------------
-- Transparent.nvim -------------------------------------------------
require("transparent").setup({
  extra_groups = {
    "NormalFloat", "StatusLine", "StatusLineNC", "VertSplit",
    "FloatBorder", "NonText", "SpecialKey", "Folded", "FoldColumn",
    "Pmenu", "CursorLine", "TabLine", "TabLineFill", "TabLineSel",
    "NvimTreeNormal", "TelescopeNormal", "WhichKeyFloat",
    "NightfoxNormal", "NightfoxFloat", "NightfoxStatusLine",
  },
  exclude_groups = {},
  enable = true,
})

-- Treesitter -------------------------------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = { "html", "css", "javascript" },
  highlight = { enable = true },
  autotag = { enable = true },
})

-- Gitsigns ---------------------------------------------------------
require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  watch_gitdir = { follow_files = true },
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
  },
  update_debounce = 100,
  diff_opts = { internal = true },
})

---------------------------------------------------------------------
-- Colourscheme -----------------------------------------------------
---------------------------------------------------------------------
vim.cmd("colorscheme nightfox")

-- Extra transparency on top of theme ------------------------------
local function apply_transparent_highlights()
  local groups = {
    "Normal", "LineNr", "SignColumn", "EndOfBuffer", "NERDTreeNormal",
    "StatusLine", "StatusLineNC", "VertSplit", "Folded", "FloatBorder",
    "Pmenu", "CursorLine", "TabLine", "TabLineFill", "TabLineSel",
  }
  for _, grp in ipairs(groups) do
    vim.cmd("hi " .. grp .. " guibg=NONE ctermbg=NONE")
  end
  if vim.fn.exists(":TransparentEnable") == 2 then
    vim.cmd("TransparentEnable")
  end
end
apply_transparent_highlights()
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_transparent_highlights,
})

---------------------------------------------------------------------
-- Keymaps ----------------------------------------------------------
---------------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic ------------------------------------------------------------
map("n", "<leader>w", ":w<CR>", opts)          -- Save
map("i", "ii", "<Esc>", opts)                 -- ii -> Esc

-- Folding (space) --------------------------------------------------
map("n", "<Space>", function()
  return vim.fn.foldlevel(".") ~= 0 and "za" or "<Space>"
end, { expr = true })
map("v", "<Space>", "zf", opts)

-- Plugin Ops -------------------------------------------------------
map("n", "<leader>s", ":CocSearch ", { noremap = true })
map("n", "<leader>f", ":Files<CR>", opts)
map("n", "<leader>g", ":Rg<CR>", opts)
map("n", "<leader>d", function()
  vim.cmd("lua ToggleNERDTreeWithRefresh()")
end, opts)
map("n", "<leader><CR>", "<CR><C-w>h:q<CR>", opts)

-- Terminals --------------------------------------------------------
map("n", "<leader>tv", ":botright vnew | terminal<CR>", opts)
map("n", "<leader>th", ":botright new | terminal<CR>", opts)
map("t", "<Esc>", [[<C-\><C-n>]], opts)

-- Window nav -------------------------------------------------------
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")

-- Undo/Redo --------------------------------------------------------
map("n", "<C-Z>", "u")
map("n", "<C-Y>", "<C-R>")
map("i", "<C-Z>", "<C-O>u")
map("i", "<C-Y>", "<C-O><C-R>")

-- Git/Gitsigns -----------------------------------------------------
map("n", "]h", ":Gitsigns next_hunk<CR>", opts)
map("n", "[h", ":Gitsigns prev_hunk<CR>", opts)
map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", opts)
map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
map("n", "<leader>hb", ":Gitsigns toggle_current_line_blame<CR>", opts)

-- Vim-Fugitive -----------------------------------------------------
map("n", "<leader>gs", ":Git<CR>")
map("n", "<leader>gc", ":Git commit<CR>")
map("n", "<leader>gd", ":Gdiff<CR>")
map("n", "<leader>gb", ":Git blame<CR>")
map("n", "<leader>gl", ":Git log<CR>")
map("n", "<leader>gp", ":Git push<CR>")
map("n", "<leader>gf", ":Git fetch<CR>")
map("n", "<leader>gpl", ":Git pull<CR>")

---------------------------------------------------------------------
-- NERDTree Helpers -------------------------------------------------
---------------------------------------------------------------------
local function is_nerdtree_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win))
    if bufname:match("NERD_tree_") then
      return true
    end
  end
  return false
end

local function toggle_nerdtree_with_refresh()
  if vim.fn.exists(":NERDTreeTabsToggle") == 2 then
    vim.cmd("NERDTreeTabsToggle")
    return
  end
  if is_nerdtree_open() then
    vim.cmd("NERDTreeClose")
  else
    if vim.fn.expand("%:p") ~= "" then
      vim.cmd("NERDTreeFind")
    else
      vim.cmd("NERDTree")
    end
  end
end
_G.ToggleNERDTreeWithRefresh = toggle_nerdtree_with_refresh

local function nerdtree_refresh_root()
  if is_nerdtree_open() then
    vim.cmd("NERDTreeClose")
    vim.defer_fn(function()
      vim.cmd("NERDTree %:p:h")
      vim.cmd("wincmd p")
    end, 100)
  else
    vim.cmd("NERDTree %:p:h")
    vim.cmd("wincmd p")
  end
end
vim.keymap.set("n", "<leader>r", nerdtree_refresh_root, opts)

-- NERDTree behaviour ------------------------------------------------
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeIgnore = { "^node_modules$", "^\\.git$", "^\\.DS_Store$" }

---------------------------------------------------------------------
-- CoC Global Variables --------------------------------------------
---------------------------------------------------------------------
vim.g.coc_start_at_startup = 1
vim.g.coc_global_extensions = {
  "coc-tsserver",
  "coc-html",
  "coc-css",
  "coc-emmet",
  "coc-prettier",
}
vim.g.coc_service_startup_timeout = 30000
vim.g.coc_default_semantic_highlight_groups = 1

---------------------------------------------------------------------
-- CoC Helpers ------------------------------------------------------
---------------------------------------------------------------------
local function coc_setup()
  vim.g.coc_disable_startup_warning = 1
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "html", "css", "less", "handlebars" },
    callback = function()
      vim.api.nvim_buf_create_user_command(0, "Format", function()
        vim.fn["CocAction"]("format")
      end, {})
    end,
  })
end
vim.api.nvim_create_autocmd("VimEnter", { callback = coc_setup })

-- Check LS status and enable embedded languages -------------------
local function check_language_server_status()
  if vim.g.coc_service_initialized == 1 then
    vim.fn["coc#config"]("languageserver.html.initializationOptions.embeddedLanguages.css", true)
    vim.fn["coc#config"]("languageserver.html.initializationOptions.embeddedLanguages.javascript", true)
  end
end
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.fn.timer_start(3000, check_language_server_status, { ["repeat"] = 6 })
  end,
})

-- Special handling for Handlebars ---------------------------------
local function setup_handlebars_env()
  vim.bo.filetype = "handlebars"
  vim.fn["coc#config"]("diagnostic.enable", false)
  vim.fn.timer_start(500, function()
    vim.cmd("CocCommand workspace.showOutput handlebars")
  end)
  vim.fn.timer_start(5000, function()
    vim.fn["coc#config"]("diagnostic.enable", true)
  end)
  vim.fn.timer_start(5500, function()
    vim.cmd("edit")
  end)
end
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.hbs", "*.handlebars" },
  callback = setup_handlebars_env,
})

---------------------------------------------------------------------
-- File-type Specific Options --------------------------------------
---------------------------------------------------------------------
-- Associate filetypes ---------------------------------------------
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.hbs", "*.handlebars" },
  callback = function()
    vim.bo.filetype = "html.handlebars"
  end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.less" },
  callback = function()
    vim.bo.filetype = "less"
  end,
})

-- Tabs = 2 for web files ------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "less", "javascript", "handlebars", "vue" },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
})

---------------------------------------------------------------------
-- Airline ----------------------------------------------------------
---------------------------------------------------------------------
vim.g.airline_theme = "transparent"
vim.g.airline_powerline_fonts = 1

---------------------------------------------------------------------
-- User Commands ----------------------------------------------------
---------------------------------------------------------------------
vim.keymap.set("n", "<leader>cr", ":CocRestart<CR>", opts)

---------------------------------------------------------------------
-- Auto-close plugin ------------------------------------------------
---------------------------------------------------------------------
require("autoclose").setup() 