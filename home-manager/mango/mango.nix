{ pkgs, ... }:

{
  xdg.configFile."mango/config.conf".source = ./dotfiles/config.conf;
  xdg.configFile."mango/waybar/config".source = ./dotfiles/waybar_config;
  xdg.configFile."mango/waybar/style.css".source = ./dotfiles/waybar_style.css;
}
