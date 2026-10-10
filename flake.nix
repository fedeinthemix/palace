{
  description = "Palace EM Simulator";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-24.11;
  };

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      pkgs = forAllSystems (system: nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (system: rec {

        palace_0_13 = pkgs.${system}.callPackage ./0.13.0.nix { };

        default = palace_0_13;

      });
    };
}
