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

    cp ${pkgs.fetchurl {
      url = "https://github.com/SorkinType/Alata/raw/3b051d2a6181deba154717cfd6be409effe32ffa/fonts/ttf/Alata-Regular.ttf";
      hash = "sha256-e3FDKl4uJAmjWDVTvFznAyCai86bLxNsolesTC063cQ=";
    }} $out/share/fonts/truetype/Alata-Regular.ttf

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/Hiragino%20Sans%20GB.ttc";
      hash = "sha256-7KHSahvEk0kPWiRQ/RuTHkoYIsw3KIEQFjrm6ZONQTA=";
    }} "$out/share/fonts/truetype/Hiragino Sans GB.ttc"

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/Times.ttc";
      hash = "sha256-IOPciZEvSzfywprddkhVFk76+0xmyjJVHZ61LHQRx8c=";
    }} $out/share/fonts/truetype/Times.ttc

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/445960b108f32ccb93803ee8f37ef28413e0662f/fonts/ShangguSansSC-VF.otf";
      hash = "sha256-W1is5D8VaS47nxa6g+YA/HRIHlIdDhrAW3/bSrYdoPo=";
    }} $out/share/fonts/opentype/ShangguSansSC-VF.otf

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/445960b108f32ccb93803ee8f37ef28413e0662f/fonts/ShangguSansST-VF.otf";
      hash = "sha256-CODuf/eKlpCCoU93l1hhqY87iAe0I6kVfbSF8EaUdC0=";
    }} $out/share/fonts/opentype/ShangguSansST-VF.otf

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/445960b108f32ccb93803ee8f37ef28413e0662f/fonts/ShangguSerifSC-VF.otf";
      hash = "sha256-WPJwMN//NAWiGT769rr+dT5MCm9ZoYrzch46jJVhzew=";
    }} $out/share/fonts/opentype/ShangguSerifSC-VF.otf

    cp ${pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/445960b108f32ccb93803ee8f37ef28413e0662f/fonts/ShangguSerifST-VF.otf";
      hash = "sha256-c6JPHjj+8ppiaDyq6XfmwVT3YozAxdKdNFGtWZNYoOE=";
    }} $out/share/fonts/opentype/ShangguSerifST-VF.otf
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
      # serif = [  "Liberation Serif" "Noto Serif CJK HK" ];
      # sansSerif = [ "Ubuntu" "Sarasa UI HC" ];
      monospace = [ "Ubuntu Mono Nerd Font" ];
      # serif = [  "Times" "Noto Serif CJK HK" ];
      # sansSerif = [ "SF Pro" "PingFang SC" ];
      # monospace = [ "JetBrainsMono Nerd Font" ];
      serif = [  "Liberation Serif" "Shanggu Serif ST VF" ];
      sansSerif = [ "Ubuntu" "Shanggu Sans ST VF" ];
    };
  };
};
}
