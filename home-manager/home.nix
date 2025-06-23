{ config, pkgs, inputs, system, ... }:

{
  home.username = "picharsiu";
  home.homeDirectory = "/home/picharsiu";

  imports = [
    ./yazi.nix
    ./sway.nix
    # ./foot.nix
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
  ];

  home.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    # XMODIFIERS = "@im=fcitx";
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
