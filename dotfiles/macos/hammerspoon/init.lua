local utils = require("utils")

hs.loadSpoon("EmmyLua")

hs.window.animationDuration = 0

hs.hotkey.bind({ "cmd", "ctrl" }, "c", function()
  hs.window.focusedWindow():centerOnScreen()
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "return", function()
  hs.window.focusedWindow():maximize()
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "left", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  win:setFrame({
    x = screen.x,
    y = screen.y,
    w = screen.w / 2,
    h = screen.h,
  })
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "right", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  win:setFrame({
    x = screen.x + screen.w / 2,
    y = screen.y,
    w = screen.w / 2,
    h = screen.h,
  })
end)

local changeWindowStep = 100

hs.hotkey.bind({ "cmd", "ctrl" }, "[", function()
  utils.changeWindowSize(-changeWindowStep)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "]", function()
  utils.changeWindowSize(changeWindowStep)
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "k", utils.makeAppLauncher("KeePassXC"))
hs.hotkey.bind({ "cmd", "ctrl" }, "o", utils.makeAppLauncher("Obsidian"))
hs.hotkey.bind({ "cmd", "ctrl" }, "b", utils.makeAppLauncher("Google Chrome"))
