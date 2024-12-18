{ config, pkgs, pkgsUnstable, libs, ... }:
{
  home.file = {
    # Building this configuration will create symlink ".config/nvim" to the
    # nvim-kickstart folder here. Using the mkOutOfStoreSymlink will point to
    # the folder directly rather than pointing to a copy in the nix-store. This
    # makes it easier/faster to modify the config, since I can modify it
    # directly.
    #".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nixpkgs/home-manager/modules/nvim-kickstart";
  };
}

