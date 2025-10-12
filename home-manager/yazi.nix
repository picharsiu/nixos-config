{ pkgs, ... }:

{
programs.yazi = {
  enable = true;
  enableFishIntegration = true;
  shellWrapperName = "y";

  settings = {
    mgr = {
      show_hidden = true;
    };
    preview = {
      max_width = 1000;
      max_height = 1000;
    };
  };

  plugins = {
    mount = pkgs.yaziPlugins.mount;
  };

  # initLua = ''
    # require("full-border"):setup()
  # '';

  keymap = {
    mgr.prepend_keymap = [
      {
        on = ["M"];
        run = "plugin mount";
      }
    ];
  };
};
}
