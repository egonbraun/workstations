{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    shellIntegration.enableZshIntegration = true;
    themeFile = "Catppuccin-Mocha";

    font = {
      name = "Inconsolata LGC Nerd Font";
      size = 14.0;
    };

    keybindings = {
    };

    settings = {
      background_blur = 5;
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      hide_window_decorations = true;
      window_margin_width = 10;
      mouse_hide_wait = "-1.0";
      scrollback_lines = 10000;
      update_check_interval = 0;
      window_padding_width = 10;
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };
}