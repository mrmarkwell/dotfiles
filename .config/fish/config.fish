if status --is-interactive
  #set the stty settings so we can run gcert automatically. More info:
  #https://g3doc.corp.google.com/company/tools/fish/index.md#enable-proper-stty-settings-at-startup
  stty icrnl icanon iexten echo

  prodcertstatus --quiet --check_remaining_hours 1 >/dev/null 2>&1
  or prodaccess -s

# Example Usage - find and replace in cpp files
#       Make sure you're replacing only stuff you want to replace
#   $ grepc SearchTerm
#       Replace stuff
#   $ findc | xargs sed -i 's/SearchTerm/ReplaceTerm/g'
#       Or
#   $ sedc -i 's/SearchTerm/ReplaceTerm/g'
abbr -a rg "rg --no-heading --no-ignore-vcs --hidden --follow" # ripgrep is _way_ faster than grep.
abbr -a fd "fdfind" # fd is _way_ faster than find.
abbr -a findc "fd -e cc -e cpp -e c -e h"
abbr -a grepc "findc | xargs rg"
abbr -a sedc "findc | xargs sed"

alias -s back 'prevd' > /dev/null
alias -s next 'nextd' > /dev/null

abbr -a tmux 'tmx2'

abbr -a aliashelp 'less ~/.config/fish/config.fish | grep alias'
abbr -a tmuxhelp 'less ~/.tmux.conf'
abbr -a nvimhelp 'less ~/nvimhelp.txt'

abbr -a cdnvim 'cd ~/dotfiles/.config/nvim'

# Use nvim
abbr -a vim nvim
# Profile startup time of nvim (~140ms as fo this commit)
abbr -a neovimspeed 'hyperfine "nvim --headless +qa" --warmup 5'

# Fish prompt
fish_add_path ~/.cargo/bin

# Make sure we start at home.
cd
end

