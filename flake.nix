{
  description = "evergarden theme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {self, nixpkgs}: let
    palette = {
      red      = "E67E80";
      orange   = "E69875";
      yellow   = "DBBC7F";
      green    = "B2C98F";
      aqua     = "93C9A1";
      sky      = "97C9C3";
      blue     = "9BB5CF";
      purple   = "D6A0D1";
      pink     = "E3A8D1";
      text     = "D9E4DC";
      subtext1 = "C9D6D0";
      subtext0 = "AEC2BE";
      overlay2 = "99ADAD";
      overlay1 = "6E8585";
      overlay0 = "5E6C70";
      surface2 = "46545B";
      surface1 = "3D494F";
      surface0 = "343E44";
      base     = "252B2E";
      mantle   = "1C2225";
      crust    = "171C1F";
    };
  in {
    palette = palette;
    base16 = {
      base00 = palette.base;
      base01 = palette.surface0;
      base02 = palette.surface2;
      base03 = palette.surface0;
      base04 = palette.overlay1;
      base05 = palette.text;
      base06 = palette.subtext1;
      base07 = palette.overlay2;
      base08 = palette.red;
      base09 = palette.orange;
      base0A = palette.yellow;
      base0B = palette.green;
      base0C = palette.aqua;
      base0D = palette.blue;
      base0E = palette.pink;
      base0F = palette.overlay0;
    };
  };
}
