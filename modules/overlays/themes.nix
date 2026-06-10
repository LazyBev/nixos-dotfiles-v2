final: prev: let
  inherit (final) stdenvNoCC;
in {
  caelus-theme = stdenvNoCC.mkDerivation {
    pname = "caelus-theme";
    version = "1.0.0";
    src = ../../themes/caelus-custom;
    installPhase = ''
      mkdir -p $out/share/themes/caelus-custom
      cp -r * $out/share/themes/caelus-custom/
    '';
    meta.description = "caelus GTK theme";
  };
}
