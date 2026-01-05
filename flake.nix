{
  description = "alarm when msg";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      nixpkgs,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        rec {
          default = pkgs.callPackage ./nix/package.nix { };
          discordpy-self = pkgs.callPackage ./nix/discord-py-self.nix {
            inherit discord-protos;
          };
          discord-protos = pkgs.callPackage ./nix/discord-protos.nix { };
        }
      );
    };
}
