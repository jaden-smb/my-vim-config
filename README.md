# Neovim Configuration Setup Guide

This guide will help you set up Neovim with the included Lua configuration on both Windows 11 and Linux systems. This modern setup uses Packer as the plugin manager and includes various plugins for syntax highlighting, LSP-based code completion, file navigation, Git integration, and more.

## Prerequisites

### Common Requirements (Both Windows and Linux)
- [Neovim](https://neovim.io/) (version 0.8.0 or later recommended)
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) (for CoC and related plugins)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- A terminal with a [Nerd Font](https://www.nerdfonts.com/) for icons
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for FZF text searching)

## Installation

### Linux

1. **Install Neovim:**
   ```bash
   # For Ubuntu/Debian
   sudo apt update
   sudo apt install neovim
   
   # For Arch Linux
   sudo pacman -S neovim
   
   # For Fedora
   sudo dnf install neovim
   ```

2. **Install ripgrep (for FZF searching):**
   ```bash
   # For Ubuntu/Debian
   sudo apt install ripgrep
   
   # For Arch Linux
   sudo pacman -S ripgrep
   
   # For Fedora
   sudo dnf install ripgrep
   ```

3. **Create Configuration Directory:**
   ```bash
   mkdir -p ~/.config/nvim
   ```

4. **Clone or Copy Configuration Files:**
   Copy the `init.lua` and `coc-settings.json` files to `~/.config/nvim/`

5. **Install Language Servers:**
   ```bash
   # For HTML language server
   sudo npm install -g vscode-html-language-server
   
   # For TypeScript language server
   sudo npm install -g typescript typescript-language-server
   
   # For CSS language server
   sudo npm install -g vscode-css-language-server
   ```

6. **Open Neovim and Install Plugins:**
   ```bash
   nvim
   ```
   Packer will automatically bootstrap itself on first run. After opening Neovim, run:
   ```
   :PackerInstall
   ```

7. **Install CoC Extensions:**
   The configuration automatically installs CoC extensions, but you can manually install them with:
   ```
   :CocInstall coc-tsserver coc-html coc-css coc-emmet coc-prettier
   ```

### Windows 11

1. **Install Neovim:**
   - Download the latest release from [Neovim's GitHub](https://github.com/neovim/neovim/releases/latest)
   - Extract and add the binary to your PATH

   Alternatively, use a package manager like Chocolatey:
   ```powershell
   choco install neovim
   ```
   Or Scoop:
   ```powershell
   scoop install neovim
   ```

2. **Install ripgrep:**
   ```powershell
   # Using Chocolatey
   choco install ripgrep
   
   # Using Scoop
   scoop install ripgrep
   ```

3. **Create Configuration Directory:**
   ```powershell
   mkdir -p ~/AppData/Local/nvim
   ```

4. **Clone or Copy Configuration Files:**
   Copy the `init.lua` and `coc-settings.json` files to `~/AppData/Local/nvim/`

5. **Install Language Servers:**
   ```powershell
   npm install -g vscode-html-language-server typescript typescript-language-server vscode-css-language-server
   ```

6. **Open Neovim and Install Plugins:**
   ```powershell
   nvim
   ```
   Packer will automatically bootstrap itself on first run. After opening Neovim, run:
   ```
   :PackerInstall
   ```

7. **Install CoC Extensions:**
   The configuration automatically installs CoC extensions, but you can manually install them with:
   ```
   :CocInstall coc-tsserver coc-html coc-css coc-emmet coc-prettier
   ```

## Configuration Files

This setup includes two main configuration files:

1. **init.lua**: The main Neovim configuration file written in Lua with plugins, keymaps, and settings
2. **coc-settings.json**: Configuration for the CoC (Conquer of Completion) plugin

## Included Plugins

### Core Functionality
- **Packer.nvim**: Modern plugin manager with lazy loading
- **CoC.nvim**: LSP-based completion and language server integration

### Language Support
- **vim-javascript**: JavaScript syntax highlighting
- **typescript-vim**: TypeScript syntax highlighting  
- **vim-vue**: Vue.js component support
- **vim-vue-plugin**: Enhanced Vue.js features
- **vim-mustache-handlebars**: Handlebars template support
- **html5.vim**: HTML5 syntax and omnicomplete
- **vim-css3-syntax**: CSS3 syntax highlighting
- **vim-less**: Less CSS preprocessor support
- **vim-polyglot**: Language pack for multiple languages
- **vim-terraform**: Terraform configuration language support

### Development Tools
- **nvim-treesitter**: Modern syntax highlighting and parsing
- **nvim-ts-autotag**: Auto-close HTML/XML tags
- **emmet-vim**: HTML/CSS abbreviation expansion
- **vim-prettier**: Code formatting with Prettier
- **syntastic**: Syntax checking
- **autoclose.nvim**: Auto-close brackets and quotes

### Git Integration
- **vim-fugitive**: Git wrapper for Vim
- **gitsigns.nvim**: Git signs in the gutter with modern features

### UI & Navigation
- **fzf** & **fzf.vim**: Fuzzy file finder
- **vim-airline**: Status line
- **nerdtree**: File explorer
- **vim-devicons**: File type icons
- **vim-nerdtree-tabs**: NERDTree tabs integration

### Editing Helpers
- **vim-surround**: Easily change surroundings
- **vim-closetag**: Auto-close HTML tags

### Appearance
- **nightfox.nvim**: Modern colorscheme
- **awesome-vim-colorschemes**: Collection of colorschemes
- **transparent.nvim**: Transparency support
- **neon**: Additional colorscheme option

## Key Features

- **Modern Lua Configuration**: Written in Lua for better performance and maintainability
- **Plugin Manager**: Uses Packer.nvim with automatic bootstrapping
- **Language Support**: JavaScript, TypeScript, HTML, CSS, Less, Vue.js, Handlebars, Terraform
- **Syntax Highlighting**: Treesitter-based syntax highlighting with auto-tag support
- **LSP Integration**: CoC (Conquer of Completion) for intelligent code completion
- **File Navigation**: NERDTree with custom toggle functions and FZF for fuzzy finding
- **Git Integration**: Gitsigns for inline git changes and Fugitive for Git commands
- **Theme**: Nightfox colorscheme with transparency support
- **Auto-formatting**: Prettier integration and automatic bracket/tag closing
- **Terminal Integration**: Built-in terminal support with custom mappings

## Key Mappings

The leader key is set to `,` (comma). Some important key mappings include:

- `,w`: Save file
- `,d`: Toggle NERDTree
- `,r`: Refresh NERDTree root
- `,f`: Fuzzy find files (FZF)
- `,g`: Ripgrep search
- `,s`: CoC search
- `,tv`: Open terminal in vertical split
- `,th`: Open terminal in horizontal split
- `,cr`: Restart CoC server
- `gd`: Go to definition (CoC)
- `gr`: Go to references (CoC)
- `Ctrl+j/k/h/l`: Navigate between splits
- `ii`: Exit insert mode (alternative to Escape)
- `Space`: Toggle fold (normal mode) / Create fold (visual mode)
- `Ctrl+Z/Y`: Undo/Redo (works in insert mode too)

### Git Shortcuts
- `,gs`: Git status
- `,gc`: Git commit
- `,gd`: Git diff
- `,gb`: Git blame
- `,gl`: Git log
- `,gp`: Git push
- `,gf`: Git fetch
- `,gpl`: Git pull

### Git Hunk Navigation (Gitsigns)
- `]h`: Next hunk
- `[h`: Previous hunk
- `,hp`: Preview hunk
- `,hs`: Stage hunk
- `,hu`: Undo stage hunk
- `,hr`: Reset hunk
- `,hb`: Toggle current line blame

## Troubleshooting

### Common Issues

1. **Missing Icons**:
   - Make sure you have installed and configured a [Nerd Font](https://www.nerdfonts.com/)
   - Set your terminal to use the installed Nerd Font

2. **CoC Language Server Issues**:
   - If language servers aren't working, try restarting with `,cr`
   - Check if servers are properly installed using `:CocInfo`
   - For issues with specific language servers, try reinstalling them
   - Check `:checkhealth` for diagnostic information

3. **Packer Plugin Issues**:
   - Run `:PackerSync` to update and clean plugins
   - If plugins fail to install, try `:PackerClean` followed by `:PackerInstall`
   - For compilation issues, delete the `plugin/packer_compiled.lua` file and restart Neovim

4. **Treesitter Issues**:
   - If syntax highlighting is broken, try `:TSUpdate`
   - For missing parsers, install them with `:TSInstall <language>`

5. **Transparency Issues**:
   - If transparency doesn't work, check if your terminal supports it
   - You can disable transparency by commenting out the transparent plugin configuration

6. **Windows-specific Issues**:
   - Path issues: Make sure all binaries are in your PATH
   - Permission issues: Run terminal as administrator if needed
   - PowerShell execution policy: You may need to run `Set-ExecutionPolicy RemoteSigned`

## Customization

To customize this configuration:

1. **Adding Plugins**: 
   - Add new plugins in the Packer configuration section of `init.lua`
   - Run `:PackerSync` to install them

2. **Changing Settings**:
   - Modify settings in `init.lua` for Neovim and plugins
   - Modify settings in `coc-settings.json` for CoC-related configurations

3. **Custom Keymaps**:
   - Add or modify keymaps in the keymaps section of `init.lua`

4. **Theme Customization**:
   - Change the colorscheme by modifying the `vim.cmd("colorscheme nightfox")` line
   - Adjust transparency settings in the transparent plugin configuration

5. **Language Support**:
   - Add new language servers in `coc-settings.json`
   - Install additional Treesitter parsers with `:TSInstall <language>`

## Updating

1. **Update Neovim**:
   - Linux: Use your package manager
   - Windows: Download new release or use `choco upgrade neovim` or `scoop update neovim`

2. **Update Plugins**:
   - Inside Neovim, run `:PackerUpdate` or `:PackerSync`

3. **Update CoC Extensions**:
   - Inside Neovim, run `:CocUpdate`

4. **Update Treesitter Parsers**:
   - Inside Neovim, run `:TSUpdate`
