{ config, pkgs, pkgsUnstable, libs, ... }:
{


  home.file = {
    # Building this configuration will create a copy of '' in
    # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # symlink to the Nix store copy.
    ".config/nvim".source = ./nvim-kickstart;
  };
}

