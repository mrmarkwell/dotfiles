# This file is the configuration for the markwells-mbp host.
# It composes other nix files to configure my macbook how I want it.
# markwells-mbp is the name of the host. Add new hosts in the same way.
# load this with `home-manager switch --flake .#markwells-mbp`
{ config, lib, pkgs, ... }:

{
# If you want to control things directly with nix, they should be imported here.
  imports = [
    ./modules/home-manager.nix
    ./modules/common.nix
    ./modules/git.nix
    ./modules/tmux.nix
    ./modules/fish.nix
#    ./modules/neovim.nix
#    ./modules/ssh.nix
  ];

# If you just want nix to copy dotfiles into the right spots, this is how to manage that.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.


  home.username = "markwell";
  home.homeDirectory = "/Users/markwell";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

