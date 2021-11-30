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

-- Shows help
hs.hotkey.bind(mash.move, 'h', function()
  hs.alert.show(help(), {
    textColor = hs.drawing.color.hammerspoon.white,
    textFont = 'Monaco',
    textSize = 30
  }, 5)
end)

local h = hs.hotkey.showHotkeys({}, "F19")
hs.hotkey.bind(mash.move, 'k',     function() hs.window.focusedWindow():move(units.top50,      nil, true) end)
hs.hotkey.bind(mash.move, 'j',     function() hs.window.focusedWindow():move(units.bot50,      nil, true) end)
hs.hotkey.bind(mash.move, ']',     function() hs.window.focusedWindow():move(units.upright30,  nil, true) end)
hs.hotkey.bind(mash.move, '[',     function() hs.window.focusedWindow():move(units.upleft70,   nil, true) end)
hs.hotkey.bind(mash.move, ';',     function() hs.window.focusedWindow():move(units.botleft70,  nil, true) end)
hs.hotkey.bind(mash.move, "'",     function() hs.window.focusedWindow():move(units.botright30, nil, true) end)
hs.hotkey.bind(mash.move, 'm', function()
  showKeyAlert(mash.move, 'M')
  hs.window.focusedWindow():move(units.maximum, nil, true)
end)

hs.hotkey.bind(mash.resize, 'left', function()
  showKeyAlert(mash.resize, '←')
  hs.window.focusedWindow():move(units.left50, nil, true)
end)

hs.hotkey.bind(mash.resize, 'right', function()
  showKeyAlert(mash.resize, '→')
  hs.window.focusedWindow():move(units.right50, nil, true)
end)

hs.hotkey.bind(mash.move, 'left', function()
  showKeyAlert(mash.move, '←')
  hs.grid.pushWindowLeft(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash.resize, 'left', function()
  showKeyAlert(mash.resize, '←')
  hs.grid.resizeWindowThinner(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash.move, 'right', function()
  showKeyAlert(mash.move, '→')
  hs.grid.pushWindowRight(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash.resize, 'right', function()
  showKeyAlert(mash.resize, '→')
  hs.grid.resizeWindowWider(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash.move, 'up', function()
  showKeyAlert(mash.move, '↑')
  hs.grid.pushWindowUp(hs.window.focusedWindow())
end)

hs.hotkey.bind(mash.move, 'down', function()
  showKeyAlert(mash.move, '↓')
  hs.grid.pushWindowDown(hs.window.focusedWindow())
end)
