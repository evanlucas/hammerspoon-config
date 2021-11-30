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
  hs.alert.closeAll()
  if appLauncherAlertWindow ~= nil then
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

    B - quick open websites
    C - open Visual Studio Code
    H - show help
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

-- function dump(o)
--   if type(o) == 'table' then
--      local s = '{ '
--      for k,v in pairs(o) do
--         if type(k) ~= 'number' then k = '"'..k..'"' end
--         s = s .. '['..k..'] = ' .. dump(v) .. ','
--      end
--      return s .. '} '
--   else
--      return tostring(o)
--   end
-- end

local chooser = hs.chooser.new(function(choice)
  if not choice then
    return
  end

  local cmd = "open " .. choice.url
  hs.execute(cmd)
end)

local quick_sites = {
  {
    text = "buzzsaw dashboard",
    subText = "Sysdig Dashboard for buzzsaw",
    url = "https://app.sysdigcloud.com/#/dashboards/248861"
  }
, {
    text = "sysdig landing page"
  , subText = "Sysdig Landing Page"
  , url = "https://app.sysdigcloud.com/#/dashboards/225423"
  }
, {
    text = "archive-upload-worker dashboard"
  , subText = "Sysdig Dashboard for archive-upload-worker"
  , url = "https://app.sysdigcloud.com/#/dashboards/221133"
  }
, {
    text = "global-at-proxy dashboard"
  , subText = "Sysdig Dashboard for global-at-proxy"
  , url = "https://app.sysdigcloud.com/#/dashboards/211901"
  }
, {
    text = "Jira"
  , subText = "My work"
  , url = "https://logdna.atlassian.net/jira/your-work"
  }
  -- Need to figure out how to automatically get the code
  -- document.querySelector('[aria-label="Copy code"] code').innerText is the selector
  -- once the page has loaded after we have logged in. We would need to support clicking
  -- the login button if we are not logged in though.
, {
    text = "IBM Auth"
  , subText = "Used to login to IBM Cloud"
  , url = "https://identity-2.us-south.iam.cloud.ibm.com/identity/passcode"
  }
}

chooser:choices(quick_sites)

launchMode:bind({}, 'b',  function()
  leaveMode()
  chooser:show()
end)

launchMode:bind({}, 'c', function() switchToApp('com.microsoft.VSCode') end)
launchMode:bind({}, 'h',  function()
  hs.alert(help_app_mode(), {
    textFont = 'Monaco'
  }, 3600)
end)
launchMode:bind({}, 's',  function() switchToApp('com.apple.Safari') end)
launchMode:bind({}, 't',  function() switchToApp('com.apple.Terminal') end)
launchMode:bind({}, '1',  function() switchToApp('com.agilebits.onepassword7') end)

-- Unmapped keys

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
