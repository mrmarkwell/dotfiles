# Steps I used to set up a new mac from scratch.


1. Install homebrew via the terminal command (see website).
2. Set up ssh key for github and add it to github profile.
3. Install Devtools: `xcode-select --install`
4. Brew installs:
```
brew install --cask ghostty
brew install --cask font-maple-mono-nf
brew install --cask font-commit-mono-nerd-font
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-roboto-mono-nerd-font
brew install fish eza hyperfine
brew install bazel llvm dust stow
brew install file neofetch fzf bat htop delta rust
brew install lld starship zoxide ripgrep fd cowsay fortune coreutils 
brew install fastfetch shfmt mdformat pigz
brew install ninja cmake gettext curl 
brew install luarocks
```
5. Clone my dotfiles repo into $HOME.
6. Go into ~/dotfiles/config_rewrite_2025 and run `stow .`
7. Download, build, and install latest Neovim.

TODO:
3. Go through a zellij tutorial (replace tmux).
4. Go through anything in ~/dotfiles/.config
5. Neovim - watch TJ's videos and others to get started. Maybe find a Neovim 11 getting started guide.

