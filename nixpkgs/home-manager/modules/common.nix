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
    zoxide # habitual `cd`

    # better du alternative
    du-dust
    ripgrep
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

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  programs.dircolors = {
    enable = true;
  };

}

