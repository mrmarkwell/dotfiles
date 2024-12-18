# Any home-manager stuff that is common across _all_ systems goes here.
{ config, pkgs, libs, ... }:
{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
