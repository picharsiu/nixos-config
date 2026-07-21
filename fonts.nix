{ inputs, pkgs, lib, ... }:

let
  my-github-fonts-collection = pkgs.runCommand "my-github-fonts-collection" {} ''
    mkdir -p $out/share/fonts/truetype
    mkdir -p $out/share/fonts/opentype

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/PingFang.ttc";
      hash = "sha256-gyC24au46C2hMQmukddIVP2ACjIPYvi1wDiko2NdrNw=";
    }} $out/share/fonts/truetype/PingFang.ttc

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/Futura.ttc";
      hash = "sha256-xZwE6Oh/dS4uV7Pz1Dp5PrqQep4q/8v+rIXnxneeh48=";
    }} $out/share/fonts/truetype/Futura.ttc
  '';

in
{
fonts = {
  fontDir.enable = true;
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
    my-github-fonts-collection
  ];

  fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      serif = [  "Liberation Serif" "Noto Serif CJK HK" ];
      sansSerif = [ "Ubuntu" "Sarasa UI HC" ];
      monospace = [ "Ubuntu Mono Nerd Font" ];
      # serif = [  "Times" "Noto Serif CJK HK" ];
      # sansSerif = [ "SF Pro" "PingFang SC" ];
      # monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };
};
}
