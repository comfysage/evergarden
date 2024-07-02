{
  description = "evergarden theme";

  inputs = { };

  outputs = {self}: let
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
      text     = "D5D6C8";
      subtext1 = "CCD4C1";
      subtext0 = "BBCEC0";
      overlay2 = "94AAA0";
      overlay1 = "6E8585";
      overlay0 = "5E6C70";
      surface2 = "46565B";
      surface1 = "3F4D52";
      surface0 = "313C40";
      base     = "232A2E";
      mantle   = "1A2024";
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
