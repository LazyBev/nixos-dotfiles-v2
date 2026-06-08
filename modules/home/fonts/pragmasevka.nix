{ pkgs, lib, ... }: let
  pragmasevka = pkgs.stdenvNoCC.mkDerivation {
    pname = "pragmasevka";
    version = "1.7.0";

    src = pkgs.fetchzip {
      url = "https://github.com/shytikov/pragmasevka/releases/download/v${pragmasevka.version}/Pragmasevka_NF.zip";
      hash = "sha256-QI4CHyZa3WxxGwhAZl+8d1uqcmM2tFgVwvfzGf32pcc=";
      stripRoot = false;
    };

    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      find . -name '*.ttf' -exec cp {} $out/share/fonts/truetype/ \;
    '';

    meta = {
      description = "Pragmata Pro doppelgänger made of Iosevka SS08";
      homepage = "https://github.com/shytikov/pragmasevka";
      license = lib.licenses.ofl;
    };
  };
in {
  fonts.packages = [ pragmasevka ];
}
