{
  inputs.bscpkgs.url = "sourcehut:~rodarima/bscpkgs";

  outputs = { self, bscpkgs }:
    let
      nixpkgs = bscpkgs.inputs.nixpkgs;
      supportedSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" "riscv64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ bscpkgs.overlays.default ];
          };
        in
        import ./withDot.nix { inherit pkgs; }
      );
    };
}
