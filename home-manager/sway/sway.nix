{ pkgs, ... }:

{
  # wayland.windowManager.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };

  xdg.configFile."sway/config".text = ''
    exec "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    ${builtins.readFile ./dotfiles/config}
    '';
  xdg.configFile."sway/waybar/config".source = ./dotfiles/waybar_config;
  xdg.configFile."sway/waybar/style.css".source = ./dotfiles/waybar_style.css;
}
