# Homebrew setup for macOS
if test (uname) = "Darwin"
   /opt/homebrew/bin/brew shellenv | source
end
    
# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

if status is-interactive
    # Commands to run in interactive sessions can go here

# ============= Aliases ==============

alias -s randomcowsay 'cowsay -f $(ls $HOME/dotfiles/cows/ | gshuf -n1)' > /dev/null
alias -s wisdom 'fortune | cowsay -f $(ls $HOME/dotfiles/cows/ | gshuf -n1)' > /dev/null

# set -Ux EDITOR nvim
alias back="prevd > /dev/null"
alias next="nextd > /dev/null"

# ============ Functions =============


# ========== Abbreviations ===========

# abbr -a vim nvim
abbr -a rg rg --no-heading
abbr -a rgg rg --no-heading -uuLi
abbr -a findc fd -e cc -e cpp -e c -e h
abbr -a grepc fd -e cc -e cpp -e c -e h | xargs rg
abbr -a sedc fd -e cc -e cpp -e c -e h | xargs sed
abbr -a formatcpp fd -ecc -eh | xargs clang-format -i
abbr -a sb 'source ~/.config/fish/config.fish'
abbr -a eb 'nvim ~/.config/fish/config.fish'
abbr -a du dust
abbr -a bat batcat
abbr -a cat batcat
abbr -a ls eza -b

starship init fish | source
fastfetch
wisdom
end

