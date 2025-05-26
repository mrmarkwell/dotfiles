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


# TODO:
# Zoxide
# Dust
# set EDITOR nvim
alias back="prevd > /dev/null"
alias next="nextd > /dev/null"

#       alias randomcowsay = "cowsay -f $(ls -d ~/dotfiles/cows/* | shuf -n1)";
#      alias wisdom = "fortune | cowsay -f $(ls -d ~/dotfiles/cows/* | shuf -n1)";

abbr -a eb nvim ~/dotfiles/.config/fish/config.fish
# abbr -a vim nvim

# ripgrep is _way_ faster than grep.
abbr -a rg rg --no-heading
# ripgrep is _way_ faster than grep.
abbr -a rgg rg --no-heading -uuLi
abbr -a findc fd -e cc -e cpp -e c -e h
abbr -a grepc fd -e cc -e cpp -e c -e h | xargs rg
abbr -a sedc fd -e cc -e cpp -e c -e h | xargs sed
abbr -a formatcpp fd -ecc -eh | xargs clang-format -i

starship init fish | source
end

