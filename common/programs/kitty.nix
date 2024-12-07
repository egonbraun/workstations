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
      "ctrl+1" = "first_window";
      "ctrl+2" = "second_window";
      "ctrl+3" = "third_window";
      "ctrl+4" = "fourth_window";
      "ctrl+5" = "fifth_window";
      "ctrl+6" = "sixth_window";
      "ctrl+7" = "seventh_window";
      "ctrl+8" = "eigth_window";
      "ctrl+9" = "nineth_window";
    };

    settings = {
      background_blur = 5;
      background_opacity = "0.99";
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      enabled_layouts = "tall:bias=50;full_size=1;mirrored=false";
      hide_window_decorations = true;
      mouse_hide_wait = "-1.0";
      scrollback_lines = 10000;
      tab_bar_edge = "bottom";
      tab_bar_min_tabs = 1;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' [{}]'.format(num_windows) if num_windows > 1 else ''}";
      update_check_interval = 0;
      window_margin_width = 10;
      window_padding_width = 10;
    };
  };
}
