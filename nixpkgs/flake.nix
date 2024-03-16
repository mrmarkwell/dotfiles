# This was started by copying https://github.com/schickling/dotfiles/blob/main/flake.nix
# While following the tutorial at https://youtu.be/1dzgVkgQ5mE?si=oEKWtIfDOeOjhK2w
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.11";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # darwin = {
    #   url = "github:lnl7/nix-darwin/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs: {
      homeConfigurations = {
        # Activate with `home-manager switch --flake .#markwells-mbp`
        markwells-mbp = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-darwin;
          modules = [ ./home-manager/markwells-mbp.nix ];
          extraSpecialArgs = { pkgsUnstable = inputs.nixpkgsUnstable.legacyPackages.x86_64-darwin; };
        };

      # darwinConfigurations = {
      #   markwells-mbp = darwin.lib.darwinSystem {
      #     system = "x86_64-darwin";
      #     modules = [
      #       ./darwin/markwells-mbp/configuration.nix
      #       home-manager.darwinModules.home-manager
      #       {
      #         home-manager.useGlobalPkgs = true;
      #         home-manager.useUserPackages = true;
      #         home-manager.users.markwell = import ./home-manager/markwells-mbp.nix;
      #         home-manager.extraSpecialArgs = { inherit nixpkgs; pkgsUnstable = inputs.nixpkgsUnstable.legacyPackages.x86_64-darwin; };
      #       }
      #     ];
      #     inputs = { inherit darwin nixpkgs; };
      #   };
      # };
};
};
}

