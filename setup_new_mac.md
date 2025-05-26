# Steps I used to set up a new mac from scratch.


1. Install homebrew via the terminal command (see website).
2. Set up ssh key for github and add it to github profile.
3. Brew installs:
```
brew install --cask ghostty
brew install --cask font-maple-mono-nf
brew install --cask font-commit-mono-nerd-font
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-roboto-mono-nerd-font
brew install fish eza hyperfine
brew install bazel llvm dust iputils
brew install file neofetch fzf bat htop delta rust
brew install lld starship zoxide ripgrep fd cowsay fortune coreutils 
brew install fastfetch
```
4. Clone my dotfiles repo into $HOME.
5. Go into ~/dotfiles/config_rewrite_2025 and run `stow .`
6. Download, build, and install latest Neovim.

TODO:
1. Go through my config.fish on my work computer and pull in anything really useful.
   - Also check stuff in my config.fish in the .config folder in dotfiles.
3. Go through a zellij tutorial (replace tmux).
4. Go through anything in ~/dotfiles/.config
5. Neovim





5. TODO: is this neccesary? Ghostty apparently comes with this installed.
   Install a nerdfont (Meslo is typical for me).
