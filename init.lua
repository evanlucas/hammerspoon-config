
hs.grid.GRIDHEIGHT = 1
hs.grid.GRIDWIDTH = 6
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0

units = {
  right30       = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  right70       = { x = 0.30, y = 0.00, w = 0.70, h = 1.00 },
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left70        = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  left30        = { x = 0.00, y = 0.00, w = 0.30, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  top50         = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  bot50         = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  upright30     = { x = 0.70, y = 0.00, w = 0.30, h = 0.50 },
  botright30    = { x = 0.70, y = 0.50, w = 0.30, h = 0.50 },
  upleft70      = { x = 0.00, y = 0.00, w = 0.70, h = 0.50 },
  botleft70     = { x = 0.00, y = 0.50, w = 0.70, h = 0.50 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

-- a helper function that returns another function that resizes the current window
-- to a certain grid size.
local gridset = function(x, y, w, h)
  return function()
      local win = hs.window.focusedWindow()
      hs.grid.set(
          win,
          {x=x, y=y, w=w, h=h},
          win:screen()
      )
  end
end

function help()
  return [[
    | Hot key                    | Description                         |
    | -------------------------- | ----------------------------------- |
    | Ctrl + Alt + Cmd + M       | Maximize window                     |
    | Ctrl + Alt + Cmd + ←       | Move window to left half of screen  |
    | Ctrl + Alt + Cmd + →       | Move window to right half of screen |
    | Ctrl + Alt + Cmd + ↑       | Move window to upper half of screen |
    | Ctrl + Alt + Cmd + ↓       | Move window to lower half of screen |
    | Ctrl + Alt + Cmd + P       | Move window to previous screen      |
    | Ctrl + Alt + Cmd + N       | Move window to the next screen      |
    | Alt + Cmd + →              | Make window wider                   |
    | Alt + Cmd + ←              | Make window thinner                 |
    | Ctrl + Space               | Open App Launcher                   |
  ]]
end

function showKeyAlert(keys, additional)
  local letters = {}
  for k,v in ipairs(keys) do
    table.insert(letters, v)
  end

  table.insert(letters, additional)

  local text = table.concat(letters, " + ")
  hs.alert.show(text, {
    textColor = hs.drawing.color.hammerspoon.white,
    textFont = 'Monaco',
    textSize = 50
  }, 1)
end

shift_mash = { 'shift', 'alt', 'ctrl', 'cmd' }
mash = { 'alt', 'ctrl', 'cmd' }
-- hs.hotkey.bind({}, 'escape', function()
--   hs.alert.closeAll()
-- end)
hs.hotkey.bind(mash, 'h', function()
  showKeyAlert(mash, 'H')
  hs.alert.show(help(), {
    textColor = hs.drawing.color.hammerspoon.white,
    textFont = 'Monaco',
    textSize = 30
  }, 5)
end)

resize_mash = { 'alt', 'cmd' }

local h = hs.hotkey.showHotkeys({}, "F19")
hs.hotkey.bind(mash, 'k',     function() hs.window.focusedWindow():move(units.top50,      nil, true) end)
hs.hotkey.bind(mash, 'j',     function() hs.window.focusedWindow():move(units.bot50,      nil, true) end)
hs.hotkey.bind(mash, ']',     function() hs.window.focusedWindow():move(units.upright30,  nil, true) end)
hs.hotkey.bind(mash, '[',     function() hs.window.focusedWindow():move(units.upleft70,   nil, true) end)
hs.hotkey.bind(mash, ';',     function() hs.window.focusedWindow():move(units.botleft70,  nil, true) end)
hs.hotkey.bind(mash, "'",     function() hs.window.focusedWindow():move(units.botright30, nil, true) end)
hs.hotkey.bind(mash, 'm', function()
  showKeyAlert(mash, 'M')
  hs.window.focusedWindow():move(units.maximum, nil, true)
end)

hs.hotkey.bind(shift_mash, 'left', function()
  showKeyAlert(shift_mash, '←')
  hs.window.focusedWindow():move(units.left50, nil, true)
end)

hs.hotkey.bind(shift_mash, 'right', function()
  showKeyAlert(shift_mash, '→')
  hs.window.focusedWindow():move(units.right50, nil, true)
end)

hs.hotkey.bind(mash, 'left', function()
  showKeyAlert(mash, '←')
  local frame = hs.window.focusedWindow():frame()
  local max_width = hs.window.desktop():frame().w
  local grid_item_width = max_width / hs.grid.GRIDWIDTH

  if frame.x < grid_item_width then
    print("should be making it smaller")
    -- We are making it smaller now
  end

  print("moving left " .. hs.inspect(frame))
  hs.grid.pushWindowLeft(hs.window.focusedWindow())
end)

hs.hotkey.bind(resize_mash, 'left', function()
  showKeyAlert(resize_mash, '←')
  hs.grid.resizeWindowThinner(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash, 'right', function()
  showKeyAlert(mash, '→')
  hs.grid.pushWindowRight(hs.window.focusedWindow())
end)

hs.hotkey.bind(resize_mash, 'right', function()
  showKeyAlert(resize_mash, '→')
  hs.grid.resizeWindowWider(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash, 'up', function()
  showKeyAlert(mash, '↑')
  hs.grid.pushWindowUp(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash, 'down', function()
  showKeyAlert(mash, '↓')
  hs.grid.pushWindowDown(hs.window.focusedWindow())
end)

local dirs = {
  "/Users/evan/dev/code/logdna"
}

local ignore_dirs = {
  "worktrees"
, "."
, ".."
}

local function has_value (tab, val)
  for index, value in ipairs(tab) do
      if value == val then
          return true
      end
  end

  return false
end

local function find_app_by_bundle_id(id)
  local app = hs.application.get(id)
  if win == nil then
    hs.application.open(id, 2, true)
    app = hs.application.get(id)
  end

  return app
end

local function find_win(app, hint)

  local twins = app:allWindows()
  hint = hint:lower()

  for _, w in ipairs(twins) do
    local wtitle = w:title()
    if wtitle and string.find(wtitle:lower(), hint, 0, true) then
      return w
    end
  end
end

launch_timer = nil
local function handle_after_vscode_launch(app, hint)
  local win = find_win(app, hint:match(".*/(.*)"))
  if not win then
    launch_timer = hs.timer.doAfter(2, function()
      handle_after_vscode_launch(app, hint)
      return 0
    end)
    return
  end

  win:moveOneScreenEast()
  win:move(units.maximum, nil, true)
end

local function open_vs_code(filepath)
  -- Now, open vscode and then find it and make it full screen on the right side
  hs.execute('open -a "Visual Studio Code" ' .. filepath)
  local v = find_app_by_bundle_id('com.microsoft.VSCode')
  if not v then
    print("failed to launch vscode")
    return
  end

  handle_after_vscode_launch(v, filepath)
end

local function handle_after_terminal_launch(app, hint)
  local win = find_win(app, hint)
  if not win then
    launch_timer = hs.timer.doAfter(2, function()
      handle_after_terminal_launch(app, hint)
      return 0
    end)
    return
  end

  -- we have the window, now move it
  win:moveOneScreenWest()
  win:centerOnScreen(nil, true)
  open_vs_code(hint)
end
-------------------------------------------------------------------
-- Code Launcher
--
-- Loads up all projects and allows you to choose
-- which to work on. It then opens a code window and a terminal
-- at that directory.
-------------------------------------------------------------------
local function launch_project(name, filepath)
  print("launching project " .. name .. " at " .. filepath)
  hs.execute("open -a Terminal " .. filepath)

  local t = find_app_by_bundle_id('com.apple.Terminal')
  if not t then
    print("failed to launch terminal")
    return
  end

  handle_after_terminal_launch(t, filepath)
end

hs.hotkey.bind(mash, 'c',     function()
  showKeyAlert(mash, 'C')
  local CodeLauncher = {}
  CodeLauncher.__index = CodeLauncher

  CodeLauncher.projects = {}
  CodeLauncher.project_names = {}

  function CodeLauncher:add(name, filepath)
    if has_value(self.project_names, name) then
      return
    end

    table.insert(self.projects, {
      text = name
    , filepath = filepath
    })

    table.insert(self.project_names, name)
  end

  local LOGDNA = "/Users/evan/dev/code/logdna"

  for file in hs.fs.dir(LOGDNA) do
    if not has_value(ignore_dirs, file) then
      local filepath = LOGDNA .. "/" .. file
      local name = "logdna/" .. file
      CodeLauncher:add(name, filepath)
    end
  end

  local GITHUB = "/Users/evan/dev/code/github"
  for org in hs.fs.dir(GITHUB) do
    if not has_value(ignore_dirs, org) then
      local ORG = GITHUB .. "/" .. org
      print("iterating org:" .. ORG)
      for repo in hs.fs.dir(ORG) do
        if not has_value(ignore_dirs, repo) then
          local name = org .. "/" .. repo
          local filepath = GITHUB .. "/" .. name
          CodeLauncher:add(name, filepath)
        end
      end
    end
  end

  cmd_chooser = hs.chooser.new(function(choice)
    if not choice then return end
    launch_project(choice.text, choice.filepath)
    -- Create a new terminal window
    -- hs.execute("open -a Terminal " .. choice.filepath)
    -- Move the terminal to the left screen
    local term = hs.application.open('Terminal.app')
    if not term then
      print("failed to launch terminal")
    end

    -- Find the correct terminal window
    -- for window in term:allWindows() do
    --   print("window: " .. hs.inspect(window))
    -- end
    -- Create a vscode window
    -- hs.execute('open -a "Visual Studio Code" ' .. choice.filepath)
    -- Move the vscode window to the right screen
  end)
  cmd_chooser:choices(CodeLauncher.projects)
  cmd_chooser:show()
end)

hs.loadSpoon('WindowScreenLeftAndRight')
hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration.start(spoon.ReloadConfiguration)

-------------------------------------------------------------------
-- Launcher
--
-- This is the awesome. The other stuff is all cool, but this is the
-- thing I love the most because it reduces the amount of time I
-- spend with the mouse, and is far more deterministic than trying
-- to use cmd+tab.
--
-- The idea here is to have a MODE-BASED app launching and app
-- switching system. Traditional Mac philosophy (and Emacs :D)
-- would have us contort our hands into crazy combinations of keys
-- to manipulate the state of the machine, which is a serious pain
-- in the ass. Using Hammerspoon we can avoid that.
--
-- * ctrl+space gets us into "launch mode"
-- * In "launch mode" the keyboard changes so that each key can now
--   have a new meaning. For example, the 'v' key is now responsible
--   for either launching or switching to VimR
-- * You can then map whatever you like to whatever function you'd
--   like to invoke.
--
-- It's just a big pile of awesome.
-------------------------------------------------------------------

-- We need to store the reference to the alert window
appLauncherAlertWindow = nil

-- This is the key mode handle
launchMode = hs.hotkey.modal.new({}, nil, '')

-- Leaves the launch mode, returning the keyboard to its normal
-- state, and closes the alert window, if it's showing
function leaveMode()
  if appLauncherAlertWindow ~= nil then
    hs.alert.closeSpecific(appLauncherAlertWindow, 0)
    appLauncherAlertWindow = nil
  end
  launchMode:exit()
end

-- So simple, so awesome.
function switchToApp(app)
  hs.application.open(app)
  leaveMode()
end

-- Enters launch mode. The bulk of this is geared toward
-- showing a big ugly window that can't be ignored; the
-- keyboard is now in launch mode.
hs.hotkey.bind({ 'ctrl' }, 'space', function()
  launchMode:enter()
  appLauncherAlertWindow = hs.alert.show('App Launcher Mode', {
    strokeColor = hs.drawing.color.x11.orangered,
    fillColor = hs.drawing.color.x11.cyan,
    textColor = hs.drawing.color.x11.black,
    strokeWidth = 20,
    radius = 30,
    textSize = 128,
    fadeInDuration = 0,
    atScreenEdge = 2
  }, 'infinite')
end)

function help_app_mode()
  return [[
    HELP

    C - open Visual Studio Code
    H - Show help
    S - open Safari
    T - open Terminal
    1 - open 1Password

    Press escape to exit app launcher
  ]]
end

-- When in launch mode, hitting ctrl+space again leaves it
launchMode:bind({ 'ctrl' }, 'space', function() leaveMode() end)
launchMode:bind({}, 'escape', function()
  hs.alert.closeAll()
  leaveMode()
end)

launchMode:bind({}, 'c', function() switchToApp('Visual Studio Code.app') end)
launchMode:bind({}, 'h',  function()
  hs.alert(help_app_mode(), {
    textFont = 'Monaco'
  }, 3600)
end)
launchMode:bind({}, 's',  function() switchToApp('Safari.app') end)
launchMode:bind({}, 't',  function() switchToApp('Terminal.app') end)
launchMode:bind({}, '1',  function() switchToApp('1Password 7.app') end)

-- Unmapped keys
launchMode:bind({}, 'a',  function() leaveMode() end)
launchMode:bind({}, 'b',  function() leaveMode() end)

launchMode:bind({}, 'd',  function() leaveMode() end)
launchMode:bind({}, 'e',  function() leaveMode() end)
launchMode:bind({}, 'f',  function() leaveMode() end)
launchMode:bind({}, 'g',  function() leaveMode() end)

launchMode:bind({}, 'i',  function() leaveMode() end)
launchMode:bind({}, 'j',  function() leaveMode() end)
launchMode:bind({}, 'k',  function() leaveMode() end)
launchMode:bind({}, 'l',  function() leaveMode() end)
launchMode:bind({}, 'm',  function() leaveMode() end)
launchMode:bind({}, 'n',  function() leaveMode() end)
launchMode:bind({}, 'o',  function() leaveMode() end)
launchMode:bind({}, 'p',  function() leaveMode() end)
launchMode:bind({}, 'q',  function() leaveMode() end)
launchMode:bind({}, 'r',  function() leaveMode() end)


launchMode:bind({}, 'u',  function() leaveMode() end)
launchMode:bind({}, 'v',  function() leaveMode() end)
launchMode:bind({}, 'w',  function() leaveMode() end)
launchMode:bind({}, 'x',  function() leaveMode() end)
launchMode:bind({}, 'y',  function() leaveMode() end)
launchMode:bind({}, 'z',  function() leaveMode() end)

launchMode:bind({}, '2',  function() leaveMode() end)
launchMode:bind({}, '3',  function() leaveMode() end)
launchMode:bind({}, '4',  function() leaveMode() end)
launchMode:bind({}, '5',  function() leaveMode() end)
launchMode:bind({}, '6',  function() leaveMode() end)
launchMode:bind({}, '7',  function() leaveMode() end)
launchMode:bind({}, '8',  function() leaveMode() end)
launchMode:bind({}, '9',  function() leaveMode() end)
launchMode:bind({}, '0',  function() leaveMode() end)
launchMode:bind({}, '-',  function() leaveMode() end)
launchMode:bind({}, '=',  function() leaveMode() end)
launchMode:bind({}, '[',  function() leaveMode() end)
launchMode:bind({}, ']',  function() leaveMode() end)
launchMode:bind({}, '\\', function() leaveMode() end)
launchMode:bind({}, ';',  function() leaveMode() end)
launchMode:bind({}, "'",  function() leaveMode() end)
launchMode:bind({}, ',',  function() leaveMode() end)
launchMode:bind({}, '.',  function() leaveMode() end)
launchMode:bind({}, '/',  function() leaveMode() end)

spoon.WindowScreenLeftAndRight:bindHotkeys({
  screen_left  = { {"ctrl", "alt", "cmd"}, "p" },
  screen_right = { {"ctrl", "alt", "cmd"}, "n" },
})
