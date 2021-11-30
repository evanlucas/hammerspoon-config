mash = {
  move = { 'alt', 'ctrl', 'cmd' }
, resize = { 'shift', 'alt', 'ctrl', 'cmd' }
}

require('setup')
require('keybind')
require('applauncher')

hs.loadSpoon('WindowScreenLeftAndRight')
hs.loadSpoon('ReloadConfiguration')

spoon.ReloadConfiguration.start(spoon.ReloadConfiguration)

spoon.WindowScreenLeftAndRight:bindHotkeys({
  screen_left  = { mash.move, "p" },
  screen_right = { mash.move, "n" },
})
