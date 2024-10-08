{ config, pkgs, libs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # First things first - start tmux if it isn't started.
      #if not set -q TMUX
      #    exec tmux a -d
      #end
      fish_add_path ~/.cargo/bin
      fish_add_path ~/.local/bin


      # Enable color in grep
      set -x GREP_OPTIONS '--color=auto'
      set -x GREP_COLOR '3;33'

      # TODO(markwell): Update to nvim when ready.
      set EDITOR nvim

      # Enable zoxide `z` (https://github.com/ajeetdsouza/zoxide)
      if command -v zoxide &>/dev/null
        # Use zoxide as `cd` (and `cdi`).
        zoxide init --cmd cd fish | source
      end
      wisdom
    '';
    functions = {
      whatsmyip = ''
        curl ifconfig.me
      '';
    };

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
      vim = "nvim";
      eb = "nvim ~/dotfiles/nixpkgs/home-manager/modules/fish.nix";
      sb = "source ~/.config/fish/config.fish";
      em = "nvim ~/dotfiles/nixpkgs/home-manager/modules/";
      fnvim = "nvim (fzf --layout=reverse --border=rounded --height=40% --info=hidden --prompt='> ' --pointer='❯' --marker='✓' --color='bg:#1e222a,bg+:#282c34,hl:#61afef,fg:#abb2bf,fg+:#e5c07b,info:#56b6c2,prompt:#c678dd,pointer:#61afef,marker:#98c379' --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:50%:wrap)";
      # Home manager switch.
      hms = "home-manager switch --flake /Users/markwell/dotfiles/nixpkgs#markwells-mbp";
      flakeupdate = "nix flake update /Users/markwell/dotfiles/nixpkgs";
      blaze = "bazel";
    };
  };
}
