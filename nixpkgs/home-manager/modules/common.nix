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

    go

    # Random
    hyperfine
    fortune-kind
    cowsay

    # Trying luarocks.nvim instead.
    lua51Packages.lua
    lua51Packages.luarocks

    # dev
    bazel_7
    clang-tools
    nodejs_21

    # Unstable because we want a version that uses toml, not yaml.
    pkgsUnstable.alacritty

    pkgsUnstable.neovim


    cargo
    nixpkgs-fmt

    # Fonts
    # Available fonts are the keys here:
    # https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/fonts/nerdfonts/shas.nix
    (nerdfonts.override { fonts = [ "Meslo" ]; })

    # TODO(markwell) figure out how to make this work - copyFonts takes too long
    # otherwise.
    #   nerdfonts.override
    #   { fonts = [ "MesloLGS Nerd Font" ]; }
    fontconfig

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

  fonts.fontconfig.enable = true;

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

