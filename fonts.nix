{ inputs, pkgs, lib, ... }:

{
fonts = {
  # enableDefaultPackages = true;
  packages = with pkgs; [
    ubuntu_font_family
    liberation_ttf
    noto-fonts
    sarasa-gothic
    noto-fonts-cjk-serif
    noto-fonts-emoji
    cantarell-fonts
    font-awesome
    font-awesome_5
    nerd-fonts.ubuntu-mono
    nerd-fonts.meslo-lg
    maple-mono.NF-CN-unhinted
    inputs.apple-fonts.packages.${pkg.system}.sf-pro
    inputs.apple-fonts.packages.${pkg.system}.sf-compact
    inputs.apple-fonts.packages.${pkg.system}.sf-mono
    inputs.apple-fonts.packages.${pkg.system}.ny

    (pkgs.fetchurl {
      url = "https://github.com/SorkinType/Alata/raw/3b051d2a6181deba154717cfd6be409effe32ffa/fonts/ttf/Alata-Regular.ttf";
      sha256 = "1i6x78nlrb2pl9n16bwvrs5rl803wxfbqlrmb2ihj91fbqm46wbv";
      name = "Alata-Regular.ttf";
    })
  ];

  fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      serif = [  "Liberation Serif" "Noto Serif CJK HK" ];
      sansSerif = [ "Ubuntu" "Sarasa UI HC" ];
      monospace = [ "Ubuntu Mono Nerd Font" ];
    };
  };
};
}
