local wezterm = require("wezterm")
local config = {}

config = wezterm.config_builder()

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  use_fancy_tab_bar = true,
  show_close_tab_button_in_tabs = false,
  show_tab_index_in_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  window_background_opacity = 0.65,
  text_background_opacity = 0.65,
  default_cursor_style = "SteadyUnderline",
  color_scheme = "iceberg-dark",
  font = wezterm.font("JetBrains Mono"),
  keys = {
    -- Toggle tab bar with CMD + Shift + T
    {
      key = "T",
      mods = "CMD|SHIFT",
      action = wezterm.action.EmitEvent("toggle-tabs"),
    },
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

wezterm.on("toggle-tabs", function(window, _)
  local overrides = window:get_config_overrides() or {}
  if overrides.enable_tab_bar == false then
    wezterm.log_info("tab bar shown")
    overrides.enable_tab_bar = true
  else
    wezterm.log_info("tab bar hidden")
    overrides.enable_tab_bar = false
  end
  window:set_config_overrides(overrides)
end)

return config
