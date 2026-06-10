-- Applications
hl.bind("SUPER" .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER" .. " + R", hl.dsp.exec_cmd(menu))
hl.bind("SUPER" .. " + E", hl.dsp.exec_cmd(filemanager))
hl.bind("SUPER" .. " + SHIFT + E", hl.dsp.exec_cmd(files))
hl.bind("SUPER" .. " + M", hl.dsp.exec_cmd(logout))
hl.bind("SUPER" .. " + L", hl.dsp.exec_cmd(lock))
hl.bind("SUPER" .. " + V", hl.dsp.exec_cmd(clipboard))
hl.bind("SUPER" .. " + P", hl.dsp.exec_cmd(colorpicker))
hl.bind("SUPER" .. " + A", hl.dsp.exec_cmd(volume))
hl.bind("SUPER" .. " + B", hl.dsp.exec_cmd(bluetooth))
hl.bind("SUPER" .. " + N", hl.dsp.exec_cmd(network))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd(screenshot .. " -m output"))
hl.bind("SUPER" .. " + Print", hl.dsp.exec_cmd(screenshot .. " -m region"))
hl.bind("SUPER" .. " + SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " -m window"))

-- Window management
hl.bind("SUPER" .. " + C", hl.dsp.window.close())
hl.bind("SUPER" .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind("SUPER" .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind("SUPER" .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER" .. " + J", hl.dsp.layout("togglesplit"))

-- Focus — arrows
hl.bind("SUPER" .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER" .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER" .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER" .. " + down", hl.dsp.focus({ direction = "down" }))

-- Focus — vim keys
hl.bind("SUPER" .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER" .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER" .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER" .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind("SUPER" .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER" .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER" .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER" .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Resize windows
hl.bind("SUPER" .. " + ALT + left", hl.dsp.window.resize({ x = -40, y = 0 }))
hl.bind("SUPER" .. " + ALT + right", hl.dsp.window.resize({ x = 40, y = 0 }))
hl.bind("SUPER" .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = -40 }))
hl.bind("SUPER" .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = 40 }))

-- Mouse
hl.bind("SUPER" .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER" .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces
for i = 1, 9 do
	hl.bind("SUPER" .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER" .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Scroll workspaces
hl.bind("SUPER" .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER" .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace
hl.bind("SUPER" .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER" .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Media & brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
