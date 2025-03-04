{ pkgs }:
with builtins;
let
  names = attrNames pkgs;
  gen = selected:
    let
      drv = pkgs.mkShell {
        inherit (selected) inputsFrom packages;
      };
      mkAttrs = isInputs: (map
        (n:
          {
            name = (if isInputs then "@" else "") + n;
            value = (gen (if isInputs
            then { inherit (selected) packages; inputsFrom = selected.inputsFrom ++ [ (getAttr n pkgs) ]; }
            else { inherit (selected) inputsFrom; packages = selected.packages ++ [ (getAttr n pkgs) ]; }
            ));
          }
        )
        names);
      attrs_list = (mkAttrs true) ++ (mkAttrs false);
      env = drv.overrideAttrs (oa: {
        passthru =
          listToAttrs attrs_list
          // { _passthru = drv.passthru; };
      });
    in
    env;
in
gen { inputsFrom = [ ]; packages = [ ]; }
