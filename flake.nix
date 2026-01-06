{
  description = "alarm when msg";

  inputs = {
    nixpkgs.url = "github:PerchunPak/nixpkgs/curl-imp-upd";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        inherit (self) outputs;
        inherit (pkgs) lib;

        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import ./nix/overlay.nix) ];
        };
      in
      {
        inherit pkgs;

        packages = {
          default = pkgs.alarm-msg;
          alarm-msg = pkgs.alarm-msg;
          inherit (pkgs.python3Packages) discordpy-self discord-protos;
        };

        devShell = pkgs.mkShell {
          inputsFrom = [ self.packages.${system}.default ];
          PYTHONPATH = ".";
        };
      }
    );
}
