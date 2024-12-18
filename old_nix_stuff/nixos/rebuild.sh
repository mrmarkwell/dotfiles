#!/usr/bin/env bash
# A rebuild script that commits on a successful build
set -e

# cd to your config dir
pushd ~/dotfiles/nixos/

# Edit your config
$EDITOR configuration.nix

# Autoformat your nix files
alejandra . &>/dev/null

# Shows your changes
git diff -U0 *.nix

echo "NixOS Rebuilding..."

# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch &>nixos-switch.log || (cat nixos-switch.log | grep --color error && false)

# Get current generation metadata
current=$(nixos-rebuild list-generations 2>/dev/null | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

# Back to where you were
popd

echo "Rebuild complete!"
