{
  outputs = { self, nixpkgs }:
    let
      inherit (nixpkgs.lib)
        genAttrs
      ;

      templateNames = [
        "nix"
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
