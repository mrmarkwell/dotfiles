{ config, pkgs, lib, libs, ... }:
{
  home.packages = with pkgs; [
    # Needed for nifty status line stuff below.
    tmux-mem-cpu-load
  ];
  programs.tmux = {
    enable = true; # Enable tmux.
    clock24 = false; # 12h clock mode.
    shell = "${pkgs.fish}/bin/fish"; # Use fish.
    terminal = "screen-256color"; # Full color.
    historyLimit = 100000; # Keep a lot of history.
    # TODO: Investigate why "sensible" plugin uses emacs and says it is strictly
    # better, even for vim users.
    keyMode = "vi"; # Use Vi keybindings.
    mouse = false; # Let Alacritty handle the mouse.
    escapeTime = 0; # No delay when processing esc.
    newSession = true; # Auto start new session.
    prefix = "C-Space"; # Control space is leader for tmux.
    plugins = with pkgs;
      [
        # TODO: Investigate https://github.com/rothgar/awesome-tmux

        # Add plugins here.
      ];
    extraConfig = ''
      ${lib.fileContents ./tmux.conf}
    '';
  };
}
