{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.kitty = {
    shellIntegration.enableZshIntegration = true;
    themeFile = "Dracula";

    font = {
      name = "Inconsolata LGC Nerd Font";
      size = "14";
    };

    keybindings = {
    };

    settings = {
      background_blur = 5;
      background_opacity = "0.5";
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      scrollback_lines = 10000;
      update_check_interval = 0;
      window_padding_width = 10;
    };
  };
}
