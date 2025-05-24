# Steps I used to set up a new mac from scratch.


1. Install homebrew via the terminal command (see website).
2. Set up ssh key for github and add it to github profile.
3. Install ghostty with brew.
`brew install --cask ghostty`
4. Clone my dotfiles repo into $HOME.
5. Install fish shell. 
`brew install fish`
6. Setup Git config: TODO: Should this be done by just linking to my existing config?
```
git config --global user.name "Matthew Markwell"
git config --global user.email matthewmarkwell@gmail.com
```

TODO:
- Investigate stow as a mechanism for getting my config dotfiles into XGD_CONFIG_HOME?
- Setup XGD_CONFIG_HOME:
```
# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
```
- Go through ghostty config documentation to get that set up.



5. TODO: is this neccesary? Ghostty apparently comes with this installed.
   Install a nerdfont (Meslo is typical for me).
