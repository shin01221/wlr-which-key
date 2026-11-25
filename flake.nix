{
  description = "wlr-which-key with repeat and per-corner radius options";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.wlr-which-key.overrideAttrs (old: {
            src = ./.;
          });
          wlr-which-key = self.packages.${system}.default;
        }
      );
    };
}
