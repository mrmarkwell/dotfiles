# Nix-based Configuration

The goal of this subdir is to make my system config nix-based, and thus, easily reproducible anywhere.

To get started, install nix and home-manager and then run:

`home-manager switch --flake .#markwells-mbp`

The `markwells-mbp` in the above command is the name of this host. To make a _new_ host, add it to the flake.nix file, and add the corresponding new_host.nix file in `home-manager/`, including any of the modules you want and customizing that host configuration in the host-specific file.

Notes
- Packages will not update automatically, there is some command that updates the flake.lock with all the latest versions.
- The nixpkgs and home-manager channels are explicitly 23.11 right now - this is good for deterministic and stable packages, but new hosts might need to configure the channels to match.

Steps I could not automate:
- Tide is not integrated into fish properly. Installing it manually according to the instructions provided in the github repo is required (Testing this TBD).
- If this is a macbook, the default iterm2 color scheme is trash. Import .itermcolors files (like the Tokyo Night ones here): https://github.com/folke/tokyonight.nvim/tree/main/extras
