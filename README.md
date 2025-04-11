# Neovim Configuration Setup Guide

This guide will help you set up Neovim with the included configuration on both Windows 11 and Linux systems. This setup includes various plugins for syntax highlighting, code completion, file navigation, Git integration, and more.

## Prerequisites

### Common Requirements (Both Windows and Linux)
- [Neovim](https://neovim.io/) (version 0.7.0 or later recommended)
- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) (for CoC and related plugins)
- [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/)
- A terminal with a [Nerd Font](https://www.nerdfonts.com/) for icons

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

2. **Create Configuration Directory:**
   ```bash
   mkdir -p ~/.config/nvim
   ```

3. **Clone or Copy Configuration Files:**
   Copy the `init.vim` and `coc-settings.json` files to `~/.config/nvim/`

4. **Install Vim-Plug (Plugin Manager):**
   ```bash
   sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   ```

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
   Inside Neovim, run:
   ```
   :PlugInstall
   ```

7. **Install CoC Extensions:**
   After plugins are installed, run:
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

2. **Create Configuration Directory:**
   ```powershell
   mkdir -p ~/AppData/Local/nvim
   ```

3. **Clone or Copy Configuration Files:**
   Copy the `init.vim` and `coc-settings.json` files to `~/AppData/Local/nvim/`

4. **Install Vim-Plug (Plugin Manager):**
   ```powershell
   iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$env:LOCALAPPDATA/nvim/autoload/plug.vim" -Force
   ```

5. **Install Language Servers:**
   ```powershell
   npm install -g vscode-html-language-server typescript typescript-language-server vscode-css-language-server
   ```

6. **Open Neovim and Install Plugins:**
   ```powershell
   nvim
   ```
   Inside Neovim, run:
   ```
   :PlugInstall
   ```

7. **Install CoC Extensions:**
   After plugins are installed, run:
   ```
   :CocInstall coc-tsserver coc-html coc-css coc-emmet coc-prettier
   ```

## Configuration Files

This setup includes two main configuration files:

1. **init.vim**: The main Neovim configuration file with plugins, keymaps, and settings
2. **coc-settings.json**: Configuration for the CoC (Conquer of Completion) plugin

## Key Features

- **Syntax Highlighting**: Support for JavaScript, TypeScript, HTML, CSS, Terraform, and more
- **Auto-completion**: Powered by CoC (Conquer of Completion)
- **File Navigation**: NERDTree with custom toggle function
- **Fuzzy Finding**: FZF integration for finding files and searching text
- **Git Integration**: Git signs in the gutter and fugitive for Git commands
- **Terminal Support**: Integrated terminal with custom mappings
- **Auto Brackets/Tags**: Auto-close brackets, quotes, and HTML tags
- **Code Formatting**: Prettier integration

## Key Mappings

The leader key is set to `,` (comma). Some important key mappings include:

- `,w`: Save file
- `,d`: Toggle NERDTree
- `,f`: Fuzzy find files
- `,g`: Ripgrep search
- `,s`: CoC search
- `,tv`: Open terminal in vertical split
- `,th`: Open terminal in horizontal split
- `,cr`: Restart CoC server
- `gd`: Go to definition
- `gr`: Go to references
- `Ctrl+j/k/h/l`: Navigate between splits
- `ii`: Exit insert mode (alternative to Escape)

### Git Shortcuts
- `,gs`: Git status
- `,gc`: Git commit
- `,gp`: Git push
- `,gpl`: Git pull

## Troubleshooting

### Common Issues

1. **Missing Icons**:
   - Make sure you have installed and configured a [Nerd Font](https://www.nerdfonts.com/)
   - Set your terminal to use the installed Nerd Font

2. **CoC Language Server Issues**:
   - If language servers aren't working, try restarting with `,cr`
   - Check if servers are properly installed using `:CocInfo`
   - For issues with specific language servers, try reinstalling them

3. **Plugin Installation Errors**:
   - Run `:checkhealth` to diagnose issues
   - Make sure you have Node.js and Git installed
   - Manually install problematic plugins using their installation instructions

4. **Windows-specific Issues**:
   - Path issues: Make sure all binaries are in your PATH
   - Permission issues: Run terminal as administrator if needed

## Customization

To customize this configuration:

1. **Adding Plugins**: 
   - Add new plugins between `call plug#begin()` and `call plug#end()` in `init.vim`
   - Run `:PlugInstall` to install them

2. **Changing Settings**:
   - Modify settings in `init.vim` for Neovim and plugins
   - Modify settings in `coc-settings.json` for CoC-related configurations

3. **Custom Keymaps**:
   - Add or modify keymaps in the `init.vim` file following the existing patterns

## Updating

1. **Update Neovim**:
   - Linux: Use your package manager
   - Windows: Download new release or use `choco upgrade neovim` or `scoop update neovim`

2. **Update Plugins**:
   - Inside Neovim, run `:PlugUpdate`

3. **Update CoC Extensions**:
   - Inside Neovim, run `:CocUpdate`
