{ pkgs, ... }:

{
  # wayland.windowManager.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };

  xdg.configFile."sway/config".source = ./dotfiles/config;
  xdg.configFile."sway/waybar/config".source = ./dotfiles/waybar_config;
  xdg.configFile."sway/waybar/style.css".source = ./dotfiles/waybar_style.css;
}
