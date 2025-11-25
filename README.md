# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | Description |
|---------|-------------|
| `git` | Git configuration and aliases |
| `zsh` | Zsh shell config (oh-my-zsh) |
| `tmux` | Tmux configuration |
| `wezterm` | WezTerm terminal emulator |
| `vim` | Vim configuration |
| `nvim` | Neovim configuration (lazy.nvim, telescope, harpoon) |
| `fish` | Fish shell configuration |
| `karabiner` | Karabiner-Elements keyboard remapping |
| `hammerspoon` | Hammerspoon automation (ShiftIt window management) |
| `ripgrep` | Ripgrep search configuration |

## Installation

```bash
# Clone the repo
git clone <your-repo-url> ~/dotfiles

# Install stow if needed
brew install stow

# Install all packages
cd ~/dotfiles
stow git zsh tmux wezterm vim nvim fish karabiner hammerspoon ripgrep

# Or install individual packages
stow git
stow nvim
```

## Uninstalling

```bash
cd ~/dotfiles
stow -D <package>  # Remove symlinks for a package
```

## Adding New Configs

1. Create a directory for the package: `mkdir -p ~/dotfiles/newpackage`
2. Mirror the home directory structure inside it
3. Move your config: `mv ~/.newconfig ~/dotfiles/newpackage/.newconfig`
4. Stow it: `cd ~/dotfiles && stow newpackage`

## Structure

```
dotfiles/
├── git/
│   └── .gitconfig
├── zsh/
│   ├── .zshrc
│   ├── .zprofile
│   └── .zshenv
├── tmux/
│   └── .tmux.conf
├── wezterm/
│   └── .wezterm.lua
├── vim/
│   └── .vimrc
├── nvim/
│   └── .config/nvim/
│       ├── init.lua
│       ├── vimrc.vim
│       └── lua/
├── fish/
│   └── .config/fish/
│       └── config.fish
├── karabiner/
│   └── .config/karabiner/
│       └── karabiner.json
├── hammerspoon/
│   └── .hammerspoon/
│       ├── init.lua
│       └── Spoons/
└── ripgrep/
    └── .ripgreprc
```
