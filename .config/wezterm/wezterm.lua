local wezterm = require("wezterm")
local config = {}

config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = true,
  use_fancy_tab_bar = true,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  window_background_opacity = 0.75,
  default_cursor_style = "SteadyUnderline",
  color_scheme = "iceberg-dark",
  font = wezterm.font("JetBrains Mono"),
  keys = {
    -- Switch to the previous tab with Cmd + Shift + Left
    {
      key = "LeftArrow",
      mods = "CMD|SHIFT",
      action = wezterm.action.ActivateTabRelative(-1),
    },
    -- Switch to the next tab with Cmd + Shift + Right
    {
      key = "RightArrow",
      mods = "CMD|SHIFT",
      action = wezterm.action.ActivateTabRelative(1),
    },
  },
}

return config
