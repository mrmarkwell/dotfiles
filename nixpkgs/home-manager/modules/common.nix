# Common config for all systems
{ config, pkgs, pkgsUnstable, libs, ... }:
{

  home.packages = with pkgs; [
    fish
    tmux
    git
    wget
    bat
    bottom
    fzf
    rename
    neofetch # fancy system + hardware info
    zoxide # better cd
    eza # better ls. (This used to be called exa, and provides 'exa' alias.
    fd # better find

    hyperfine
    fortune-kind
    cowsay

    # Unstable because we want a version that uses toml, not yaml.
    pkgsUnstable.alacritty

    pkgsUnstable.neovim

    # better du alternative
    du-dust # better du
    ripgrep # better grep
    graphviz

    # TODO check this out.
    speedtest-cli
  ] ++ lib.optionals stdenv.isDarwin [
    coreutils # provides `dd` with --status=progress
  ] ++ lib.optionals stdenv.isLinux [
    iputils # provides `ping`, `ifconfig`, ...
    file
    lsof

    libuuid # `uuidgen` (already pre-installed on mac)
  ];

  programs.dircolors = {
    enable = true;
  };

  #home.file = {
    # Building this configuration will create a copy of '' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    # ".config/alacritty/alacritty.toml".source = alacritty.toml;
  #};

}

