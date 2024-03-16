{ config, pkgs, lib, libs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Matthew Markwell";
    userEmail = "matthewmarkwell@gmail.com";

    delta = {
      enable = true;
      options = {
        syntax-theme = "Dracula";
        side-by-side = true;
      };
    };

    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "main";
      github.user = "markwell";

      push.autoSetupRemote = true;

      core.editor = "vim";
      core.fileMode = false;
      core.ignorecase = false;
    };
  };
}
