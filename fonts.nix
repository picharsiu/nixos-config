{ inputs, pkgs, lib, ... }:

{
fonts = {
  # enableDefaultPackages = true;
  packages = with pkgs; [
    ubuntu-classic
    liberation_ttf
    noto-fonts
    sarasa-gothic
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    cantarell-fonts
    font-awesome
    font-awesome_5
    nerd-fonts.ubuntu-mono
    nerd-fonts.meslo-lg
    maple-mono.NF-CN-unhinted
    nerd-fonts.jetbrains-mono
    inputs.apple-fonts.packages.${pkg.stdenv.hostPlatform.system}.sf-pro
    inputs.apple-fonts.packages.${pkg.stdenv.hostPlatform.system}.sf-compact
    inputs.apple-fonts.packages.${pkg.stdenv.hostPlatform.system}.sf-mono
    inputs.apple-fonts.packages.${pkg.stdenv.hostPlatform.system}.ny
  ];

  fontconfig = {
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      # serif = [  "Liberation Serif" "Noto Serif CJK HK" ];
      # sansSerif = [ "Ubuntu" "Sarasa UI HC" ];
      # monospace = [ "Ubuntu Mono Nerd Font" ];
      serif = [  "Times" "Noto Serif CJK HK" ];
      sansSerif = [ "SF Pro" "PingFang SC" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };
};
}
