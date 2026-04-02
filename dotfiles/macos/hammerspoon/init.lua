local utils = require("utils")

hs.loadSpoon("EmmyLua")

hs.window.animationDuration = 0

hs.hotkey.bind({ "cmd", "ctrl" }, "c", function()
  hs.window.focusedWindow():centerOnScreen()
end)

hs.hotkey.bind({ "cmd", "ctrl" }, "return", function()
  hs.window.focusedWindow():maximize()
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

