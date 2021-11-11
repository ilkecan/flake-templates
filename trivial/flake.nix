{
  description = "TODO";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      inherit (inputs.flake-utils.lib)
        defaultSystems
        eachSystem
        ;

      supportedSystems = defaultSystems;
    in
    eachSystem supportedSystems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        inherit (pkgs)
          mkShell
          ;
      in
      rec {
        packages = {
          trivial = import ./nix/trivial.nix pkgs;
        };

        defaultPackage = packages.trivial;

        devShell = mkShell {
          packages = [
          ];

          shellHook = ''
          '';
        };
      }
    );
}
