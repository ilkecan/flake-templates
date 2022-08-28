{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
    nix-utils = {
      url = "github:ilkecan/nix-utils";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    crate2nix = {
      url = "github:kolloch/crate2nix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      inherit (nixpkgs.lib)
        composeManyExtensions
        recursiveUpdate
      ;

      inherit (inputs.flake-utils.lib)
        eachDefaultSystem
      ;

      inherit (inputs.nix-utils.lib)
        mkOverlay
      ;

      mkOverlay' = mkOverlay { inherit inputs; };
    in
    recursiveUpdate
      {
        overlays = rec {
          default = composeManyExtensions [
            placeholder
          ];

          placeholder = mkOverlay' ./nix/placeholder.nix;
        };
      }
      (eachDefaultSystem (system:
        let
          importFile = file:
            import file { inherit inputs system; };
        in
        {
          packages = rec {
            default = placeholder;
            placeholder = importFile ./nix/placeholder.nix;
          };
        }
      ))
    ;
}
