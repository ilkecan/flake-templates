{
  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib)
        genAttrs
      ;

      templateNames = [
        "nix"
        "rust"
        "vim"
      ];

      mkTemplate = name:
        {
          description = name;
          path = ./templates/${name};
        };
    in
    {
      templates = genAttrs templateNames mkTemplate;
    };
}
