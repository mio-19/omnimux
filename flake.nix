{
  description = "Omnimux: Multi-tab terminal UI for local and remote tmux sessions";

  inputs = {
    nurpkgs.url = "github:mio-19/nurpkgs";
    nixpkgs.follows = "nurpkgs/nixpkgs";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nurpkgs, nixpkgs, systems }:
    let
      eachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      packages = eachSystem (system: {
        default = nurpkgs.packages.${system}.omnimux;
        omnimux = nurpkgs.packages.${system}.omnimux;
      });

      apps = eachSystem (system: {
        default = {
          type = "app";
          program = "${nurpkgs.packages.${system}.omnimux}/bin/omnimux";
        };
      });
    };
}
