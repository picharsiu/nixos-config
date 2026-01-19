{ inputs, ... }:

{
# Add Firefox GNOME theme directory
home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;

programs.firefox = {
      enable = true;
      profiles.default = {
         name = "Default";
         settings = {
            # For Firefox GNOME theme:
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.tabs.drawInTitlebar" = true;
            "svg.context-properties.content.enabled" = true;
            "gnomeTheme.hideSingleTab" = true;

            "extensions.pocket.enabled" = false;

            # widevine-cdm
            "media.gmp-widevinecdm.version" = "system-installed";
            "media.gmp-widevinecdm.visible" = true;
            "media.gmp-widevinecdm.enabled" = true;
            "media.gmp-widevinecdm.autoupdate" = false;
            "media.eme.enabled" = true;
            "media.eme.encrypted-media-encryption-scheme.enabled" = true;

            # Color Management
            # "gfx.color_management.mode" = 1;
            # "gfx.color_management.display_profile" = "/home/picharsiu/.local/share/icc/Color LCD-37D8832A-2D66-02CA-B9F7-8F30A301B230.icc";
         };
         userChrome = ''
            @import "firefox-gnome-theme/userChrome.css";
         '';
      };
   };
}
