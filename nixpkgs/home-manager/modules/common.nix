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

}

