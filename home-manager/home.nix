{ config, pkgs, inputs, system, ... }:

{
  home.username = "picharsiu";
  home.homeDirectory = "/home/picharsiu";

  imports = [
    ./yazi.nix
    ./sway.nix
    ./firefox.nix
    ./fish.nix
    ./fuzzel.nix
    ./kitty.nix
    ./waybar_config.nix
    ./waybar_style.nix
  ];

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  home.packages = with pkgs;[
    fastfetch
    font-manager
    waybar
    wev
    mpv
    bluetuith
    wechat
    btop
    wmenu
    autotiling-rs
    nautilus
    tauon
    swayimg
    asahi-bless
    niri
    xwayland-satellite
    libnotify
    art
  ];

  home.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    XMODIFIERS="@im=fcitx";
  };

  home.file = {
    ".local/share/audio/1-second-of-silence.mp3".source = pkgs.fetchurl {
      url = "https://github.com/anars/blank-audio/raw/92f06aaa1f1f4cae365af4a256b04cf9014de564/1-second-of-silence.mp3";
      sha256 = "0pa4fyskmzzkhjdg9s1zlmk6c5z3105lf03fi6k8sbh5zjcyy099";
    };
    ".local/share/icc/Color LCD-37D8832A-2D66-02CA-B9F7-8F30A301B230.icc".source = pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/bebd9b352721b53738f2f60e17dd501238df5a5c/icc/Color%20LCD-37D8832A-2D66-02CA-B9F7-8F30A301B230.icc";
      sha256 = "gF/rH0dD+70cMUQj8YikPqMyWTRNeDA8nMiZaUm/+Hc=";
    };
    ".local/share/fonts/Alata-Regular.ttf".source = pkgs.fetchurl {
      url = "https://github.com/SorkinType/Alata/raw/3b051d2a6181deba154717cfd6be409effe32ffa/fonts/ttf/Alata-Regular.ttf";
      sha256 = "e3FDKl4uJAmjWDVTvFznAyCai86bLxNsolesTC063cQ=";
    };
    ".local/share/fonts/Futura.ttc".source = pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/Futura.ttc";
      sha256 = "xZwE6Oh/dS4uV7Pz1Dp5PrqQep4q/8v+rIXnxneeh48=";
    };
    ".local/share/fonts/Hiragino Sans GB.ttc".source = pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/Hiragino%20Sans%20GB.ttc";
      sha256 = "7KHSahvEk0kPWiRQ/RuTHkoYIsw3KIEQFjrm6ZONQTA=";
    };
    ".local/share/fonts/PingFang.ttf".source = pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/PingFang.ttc";
      sha256 = "gyC24au46C2hMQmukddIVP2ACjIPYvi1wDiko2NdrNw=";
    };
    ".local/share/fonts/Times.ttf".source = pkgs.fetchurl {
      url = "https://github.com/picharsiu/resources/raw/19c8fe0149b6c60a492f257afc801c6a9a6aa976/fonts/Times.ttc";
      sha256 = "IOPciZEvSzfywprddkhVFk76+0xmyjJVHZ61LHQRx8c=";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
