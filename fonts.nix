{ inputs, pkgs, ... }:

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
    inputs.apple-fonts.packages.${pkg.system}.sf-pro
    inputs.apple-fonts.packages.${pkg.system}.sf-compact
    inputs.apple-fonts.packages.${pkg.system}.sf-mono
    inputs.apple-fonts.packages.${pkg.system}.ny
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
