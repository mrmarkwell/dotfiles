# Homebrew setup for macOS
if test (uname) = "Darwin"
   /opt/homebrew/bin/brew shellenv | source
end
    
# ======= Global Env Variables ========

# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

# Where to look for cowsay cows.
set -gx COWPATH "$HOME/dotfiles/cows"
set -gx FZF_DEFAULT_OPTS '
--layout=reverse
--border=rounded
--height=100%
--info=hidden
--prompt="> "
--pointer="❯"
--marker="✓"
--color="bg:#1e222a,bg+:#282c34,hl:#61afef,fg:#abb2bf,fg+:#e5c07b,info:#56b6c2,prompt:#c678dd,pointer:#61afef,marker:#98c379"
--preview="batcat --style=numbers --color=always --line-range :500 {}"
--preview-window=up:80%
'

if status is-interactive
    # Commands to run in interactive sessions can go here

# ============= Aliases ==============

alias -s randomcowsay 'cowsay -f $(ls $HOME/dotfiles/cows/ | gshuf -n1)' > /dev/null
alias -s wisdom 'fortune | cowsay -f $(ls $HOME/dotfiles/cows/ | gshuf -n1)' > /dev/null

# set -Ux EDITOR nvim
alias back="prevd > /dev/null"
alias next="nextd > /dev/null"


# ========== Abbreviations ===========

# Example Usage - find and replace in cpp files
#       Make sure you're replacing only stuff you want to replace
#   $ grepc SearchTerm
#       Replace stuff
#   $ findc | xargs sed -i 's/SearchTerm/ReplaceTerm/g'
#       Or
#   $ sedc -i 's/SearchTerm/ReplaceTerm/g'
# abbr -a vim nvim
abbr -a rg rg --no-heading
abbr -a rgg rg --no-heading -uuLi
abbr -a findc fd -e cc -e cpp -e c -e h
abbr -a grepc fd -e cc -e cpp -e c -e h | xargs rg
abbr -a sedc fd -e cc -e cpp -e c -e h | xargs sed
abbr -a formatcpp fd -ecc -eh | xargs clang-format -i

# Quick way to source and edit configs.
abbr -a sb 'source ~/.config/fish/config.fish'
abbr -a eb 'nvim ~/.config/fish/config.fish'
abbr -a es 'nvim ~/.config/fish/shortcuts.fish'
abbr -a en 'nvim ~/.config/nvim/init.lua'

# Replacements that are better.
# You can use `command du` to bypass the abbreviation.
abbr -a du dust
abbr -a bat batcat
abbr -a cat batcat
abbr -a ls eza -b

# My preferred shell format settings.
abbr -a myshfmt "shfmt --indent=2 --case-indent --write --space-redirects"

# Merge history from all shells!!
abbr -a hm history --merge

# ============ Functions =============

# Save history after every command
# To retrieve history in current shell, run `history --merge` in that shell!
function fish_preexec --on-event fish_preexec
    # Save history before every new command execution
    history --save
end

function cdto --wraps=cd --description 'cd to the directory containing a file'
  cd (dirname $argv); 
end

function tarball --description "Create a .tar.gz archive of a path using pigz for parallel compression"
    if test -z "$argv[1]"
        echo "Usage: tarball <path>"
        return 1
    end

    set -l input_path "$argv[1]"
    set -l output_filename "$input_path.tar.gz"
    # Calculate the number of cores to use: total cores minus 2
    # Ensure a minimum of 1 core is used
    set -l num_available_cores (nproc)
    set -l num_cores (math (max 1 (math $num_available_cores - 2)))

    echo "Compressing '$input_path' to '$output_filename' using $num_cores cores..."
    tar -cf - "$input_path" | pigz -p $num_cores > "$output_filename"

    if test $status -eq 0
        echo "Successfully created '$output_filename'"
    else
        echo "Error: Compression failed for '$input_path'"
        return $status
    end
end

function addalias --description 'quickly create aliases (technically abbrs)'
  echo "Adding new alias!"
  echo "    abbr -a $argv[1] $argv[2..]"
  echo ""
  echo "abbr -a $argv[1] $argv[2..]" >> ~/.config/fish/shortcuts.fish
  source ~/.config/fish/shortcuts.fish > /dev/null
end

# ============= Misc ==============

# Do I need this?
# fish_add_path ~/.cargo/bin
# fish_add_path ~/.local/bin

# Enable zoxide `z` (https://github.com/ajeetdsouza/zoxide)
if command -v zoxide &>/dev/null
  # Use zoxide as `cd` (and `cdi`).
  zoxide init --cmd cd fish | source
end


# ============ Wrapup =============

# Use Starship for prompt.
starship init fish | source
fastfetch
wisdom
end # End of interactive shell only section.

