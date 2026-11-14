# Dotfiles

Personal dotfiles managed with [YADM](https://yadm.io) (Yet Another Dotfiles Manager). Supports **macOS**, **Debian/Ubuntu**, and **Arch Linux**.

> **`ubuntu` branch:** a headless-server variant of the zsh config (no nvm/kubectl/mac-only
> bits). `bootstrap.d/` gains three extra Debian/Ubuntu-only steps (`20-neovim.sh`,
> `30-rust.sh`, `40-zsh-plugins.sh`) to install the latest Neovim release, Rust via rustup,
> and Oh My Zsh + Powerlevel10k + the zsh plugins `.zshrc` expects — none of which are apt
> packages, and the apt neovim/cargo packages are too old/incomplete for this config as-is.

## What's Included

| Config | Details |
|--------|---------|
| **Zsh** | Powerlevel10k prompt, aliases, functions, zoxide, fzf, nvm, autosuggestions |
| **Neovim** | NvChad-based config with lazy.nvim, LSP, conform, stylua |
| **tmux** | Catppuccin theme, TPM plugin manager, sensible defaults |
| **Git** | Global gitconfig and gitignore |
| **Ghostty** | GPU-accelerated terminal emulator |
| **Karabiner-Elements** | Keyboard customization (macOS) |
| **htop** | Process viewer config |

## Installation

1. Install [YADM](https://yadm.io/docs/install)
2. Clone and bootstrap:

```sh
yadm clone https://github.com/savety6/MyDotFilesConfig.git
yadm bootstrap
```

The bootstrap script automatically detects your OS and installs packages using the appropriate package manager:

- **macOS** -- Homebrew (`Brewfile`)
- **Debian/Ubuntu** -- apt (`packages.txt`)
- **Arch Linux** -- pacman (`packages.txt`)

## Key Packages

**CLI tools:** eza, fd, fzf, ripgrep, jq, zoxide, tldr, lazygit, htop, nmap

**Languages & runtimes:** Go (+ full toolchain), Rust/Cargo, Bun, Node (via nvm)

**macOS apps (via Homebrew cask):** Ghostty, Cursor, VS Code, Brave, Obsidian, Rectangle, Raycast, Docker Desktop, Blender, and more

## Repository Structure

```
~
├── .config/
│   ├── nvim/           # Neovim (NvChad)
│   ├── tmux/           # tmux + plugins
│   ├── zsh/            # Zsh aliases, functions, p10k
│   ├── karabiner/      # Keyboard remapping
│   ├── pkg/            # Package lists per OS
│   │   ├── brew/       #   Brewfile (macOS)
│   │   ├── apt/        #   packages.txt (Debian)
│   │   └── pacman/     #   packages.txt (Arch)
│   └── yadm/           # Bootstrap scripts
│       ├── bootstrap
│       └── bootstrap.d/
├── .zshrc
├── .zshenv
├── .zprofile
└── .gitconfig
```
