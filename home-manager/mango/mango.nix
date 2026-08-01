{ pkgs, ... }:

{
  xdg.configFile."mango/config.conf".text = ''
    exec-once=${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    ${builtins.readFile ./dotfiles/config.conf}
    '';
  xdg.configFile."mango/waybar/config".source = ./dotfiles/waybar_config;
  xdg.configFile."mango/waybar/style.css".source = ./dotfiles/waybar_style.css;
}
