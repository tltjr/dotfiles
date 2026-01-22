-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Startup configuration: spawn tabs with explicit titles
wezterm.on('gui-startup', function(cmd)
  local mux = wezterm.mux
  local home = os.getenv("HOME")
  local tmux = "/opt/homebrew/bin/tmux"
  
  -- Run bootstrap script first to create tmux sessions with proper windows
  -- This ensures sessions exist before we try to attach
  os.execute(home .. "/dotfiles/scripts/tmux-bootstrap.sh")

  -- Tab 1: rails - local tmux session
  local tab, pane, window = mux.spawn_window({
    args = { tmux, "attach-session", "-t", "rails" },
    cwd = home .. "/src/bonfire-pit",
  })
  tab:set_title("rails")

  -- Tab 2: local - local tmux session (nvim with scratch files)
  tab = window:spawn_tab({
    args = { tmux, "attach-session", "-t", "local" },
    cwd = home,
  })
  tab:set_title("local")

  -- Tab 3: k8s - SSH via alias, then attach to remote tmux
  tab = window:spawn_tab({
    args = { "/opt/homebrew/bin/fish", "-c", "k8s-tmux" },
  })
  tab:set_title("k8s")

  -- Tab 4: pit - local tmux session
  tab = window:spawn_tab({
    args = { tmux, "attach-session", "-t", "pit" },
    cwd = home .. "/src/bonfire-pit",
  })
  tab:set_title("pit")

  -- Tab 5: wood - local tmux session
  tab = window:spawn_tab({
    args = { tmux, "attach-session", "-t", "wood" },
    cwd = home .. "/src/firewood-rack",
  })
  tab:set_title("wood")

  -- Tab 6: kindle - local tmux session
  tab = window:spawn_tab({
    args = { tmux, "attach-session", "-t", "kindle" },
    cwd = home .. "/src/bonfire-kindle",
  })
  tab:set_title("kindle")

  -- Tab 7: devbox - SSH via alias, then attach to remote tmux
  tab = window:spawn_tab({
    args = { "/opt/homebrew/bin/fish", "-c", "devbox-tmux" },
  })
  tab:set_title("devbox")
end)

config.font = wezterm.font 'DejaVu Sans Mono for Powerline'
config.font_size = 18.0
config.color_scheme = 'Dracula'
config.window_decorations = "RESIZE"

local act = wezterm.action
config.keys = {
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = act.Multiple {
      act.SendKey { key = 'RightArrow' },
      act.SendKey { key = 'Enter' },
    },
  },
  {
    key = 'a',
    mods = 'CTRL',
    action = act.SendKey { key = 'Home' },
  },
  {
    key = 'e',
    mods = 'CTRL',
    action = act.SendKey { key = 'End' },
  },
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.SendString 'clear\n',
  },
  -- CMD+number to switch wezterm tabs
  { key = '1', mods = 'CMD', action = act.ActivateTab(0) },
  { key = '2', mods = 'CMD', action = act.ActivateTab(1) },
  { key = '3', mods = 'CMD', action = act.ActivateTab(2) },
  { key = '4', mods = 'CMD', action = act.ActivateTab(3) },
  { key = '5', mods = 'CMD', action = act.ActivateTab(4) },
  { key = '6', mods = 'CMD', action = act.ActivateTab(5) },
  { key = '7', mods = 'CMD', action = act.ActivateTab(6) },
  { key = '8', mods = 'CMD', action = act.ActivateTab(7) },
  { key = '9', mods = 'CMD', action = act.ActivateTab(8) },
  -- OPT+number to switch tmux windows (sends prefix C-Space then number)
  { key = '1', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '1' } } },
  { key = '2', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '2' } } },
  { key = '3', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '3' } } },
  { key = '4', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '4' } } },
  { key = '5', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '5' } } },
  { key = '6', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '6' } } },
  { key = '7', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '7' } } },
  { key = '8', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '8' } } },
  { key = '9', mods = 'OPT', action = act.Multiple { act.SendKey { key = ' ', mods = 'CTRL' }, act.SendKey { key = '9' } } },
}

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- Fallback tab names (used if explicit title not set)
local fallback_tab_names = {
  [1] = "rails",
  [2] = "local",
  [3] = "k8s",
  [4] = "pit",
  [5] = "wood",
  [6] = "kindle",
  [7] = "devbox",
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config)
  local tab_number = tab.tab_index + 1
  
  -- Use explicit tab title if set, otherwise fall back to index-based naming
  local custom_name = tab.tab_title
  if not custom_name or custom_name == "" then
    custom_name = fallback_tab_names[tab_number] or "Tab"
  end
  
  -- Colors from Dracula theme
  local bar_bg = '#191a21'  -- Tab bar background
  local bg_color = bar_bg  -- Inactive tabs match bar background
  local fg_color = '#f8f8f2'
  
  if tab.is_active then
    bg_color = '#bd93f9'  -- Dracula purple
    fg_color = '#282a36'  -- Dark text for contrast
  end
  
  -- Powerline right-pointing triangle separator
  local right_sep = ''
  
  -- Format with powerline separator at the end
  return {
    { Background = { Color = bg_color } },
    { Foreground = { Color = fg_color } },
    { Text = string.format(' %s  %s ', tab_number, custom_name) },
    { Background = { Color = bar_bg } },
    { Foreground = { Color = bg_color } },
    { Text = right_sep },
  }
end)

config.window_frame = {
  font = wezterm.font 'DejaVu Sans Mono for Powerline',
  font_size = 16.0,
  active_titlebar_bg = '#212121',
  inactive_titlebar_bg = '#212121',
}

config.colors = {
  tab_bar = {
    background = '#191a21',  -- Darker background for tab bar
    active_tab = {
      fg_color = '#282a36',  -- Dark text
      bg_color = '#bd93f9',  -- Dracula purple
      intensity = 'Bold',
    },
    inactive_tab = {
      fg_color = '#f8f8f2',  -- Light gray
      bg_color = '#191a21',  -- Match tab bar background
    },
    inactive_tab_hover = {
      fg_color = '#f8f8f2',
      bg_color = '#6272a4',  -- Dracula comment gray (lighter)
      italic = false,
    },
    new_tab = {
      fg_color = '#f8f8f2',
      bg_color = '#282a36',  -- Dracula background
    },
    new_tab_hover = {
      fg_color = '#f8f8f2',
      bg_color = '#6272a4',
    },
  },
}

-- Mouse bindings for clickable links
-- Note: Shift bypasses tmux mouse capture, so Shift+click works inside tmux
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'SHIFT',
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = act.OpenLinkAtMouseCursor,
  },
}

-- Explicit hyperlink rules
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- and finally, return the configuration to wezterm
return config
