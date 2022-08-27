{
  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib)
        genAttrs
      ;

      templateNames = [
        "nix"
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
