{ config, pkgs, libs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
# First things first - start tmux if it isn't started.
if not set -q TMUX
    exec tmux a -d
end
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin


      # Setup terminal, and turn on colors
      set -x TERM xterm-256color

      # Enable color in grep
      set -x GREP_OPTIONS '--color=auto'
      set -x GREP_COLOR '3;33'

      # TODO(markwell): Update to nvim when ready.
      set EDITOR vim

      # Enable zoxide `z` (https://github.com/ajeetdsouza/zoxide)
      if command -v zoxide &>/dev/null
        # Use zoxide as `cd` (and `cdi`).
        zoxide init --cmd cd fish | source
      end
wisdom
    '';
    functions = {
# TODO(markwell): Add any fish functions that I want here.
      hm = ''
        pushd ~/dotfiles/nixpkgs
        home-manager switch --flake .#$argv[1]
        popd
      '';

      whatsmyip = ''
        curl ifconfig.me
      '';
    };
# TODO(markwell): Add TIDE here.
#    plugins = [
#      {
#      }
#    ];
    shellAliases = {

back = "prevd > /dev/null";
next = "nextd > /dev/null";

# Just for fun (cool cows from https://github.com/paulkaefer/cowsay-files)
randomcowsay = "cowsay -f $(ls -d ~/dotfiles/cows/* | shuf -n1)";
wisdom = "fortune | cowsay -f $(ls -d ~/dotfiles/cows/* | shuf -n1)";
    };

    shellAbbrs = {
# Example Usage - find and replace in cpp files
#       Make sure you're replacing only stuff you want to replace
#   $ grepc SearchTerm
#       Replace stuff
#   $ findc | xargs sed -i 's/SearchTerm/ReplaceTerm/g'
#       Or
#   $ sedc -i 's/SearchTerm/ReplaceTerm/g'
rg = "rg --no-heading"; # ripgrep is _way_ faster than grep.
rgg = "rg --no-heading -uuLi"; # ripgrep is _way_ faster than grep.
findc = "fd -e cc -e cpp -e c -e h";
grepc = "fd -e cc -e cpp -e c -e h | xargs rg";
sedc = "fd -e cc -e cpp -e c -e h | xargs sed";
formatcpp = "fd -ecc -eh | xargs clang-format -i";
ls = "exa";
l = "exa -l --icons --git -a";
lt = "exa --tree --level=2 --long --icons --git";
du = "dust";
neovim = "hyperfine 'nvim --headless +qa' --warmup 5";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
    };
  };
}
