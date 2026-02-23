{
  inputs.jungle.url = "https://jungle.bsc.es/git/rarias/jungle/archive/master.tar.gz";

  outputs = { self, jungle }:
    let
      supportedSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" "riscv64-linux" ];
      forAllSystems = jungle.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import jungle {
            inherit system;
          };
        in
        import ./withDot.nix { inherit pkgs; }
      );
    };
}
