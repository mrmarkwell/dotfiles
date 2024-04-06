{ config, pkgs, pkgsUnstable, libs, ... }:
{
  home.file = {
    # symlink to the alacritty folder defined here.
    ".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixpkgs/home-manager/modules/alacritty";
  };
}

