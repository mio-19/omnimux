{
  description = "Omnimux: Multi-tab terminal UI for local and remote tmux sessions";

  inputs = {
    nurpkgs.url = "github:mio-19/nurpkgs";
    nixpkgs.follows = "nurpkgs/nixpkgs";
  };

  outputs = { self, nurpkgs, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: {
        default = nurpkgs.packages.${system}.omnimux;
        omnimux = nurpkgs.packages.${system}.omnimux;
      });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${nurpkgs.packages.${system}.omnimux}/bin/omnimux";
        };
      });
    };
}
