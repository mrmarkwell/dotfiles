{ config, pkgs, lib, libs, ... }:
{
  home.packages = with pkgs; [
    # Needed for nifty status line stuff below.
    tmux-mem-cpu-load
  ];
  programs.tmux = {
    enable = true;
    clock24 = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs;
      [
        # Add plugins here.
      ];
    extraConfig = ''
      ${lib.fileContents ./tmux.conf}
    '';
  };
}
