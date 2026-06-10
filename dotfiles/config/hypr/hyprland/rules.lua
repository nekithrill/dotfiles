hl.dwindle({
	pseudotile = true,
	preserve_split = true,
	smart_split = false,
	smart_resizing = false,
})

local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

-- Floating system utils
hl.window_rule({
	name = "float-nm",
	match = { class = "^nm-connection-editor$" },
	float = true,
})

hl.window_rule({
	name = "float-blueman",
	match = { class = "^blueman-manager$" },
	float = true,
	size = "700 500",
	center = true,
})

hl.window_rule({
	name = "float-pavucontrol",
	match = { class = "^org.pulseaudio.pavucontrol$" },
	float = true,
	size = "600 400",
	center = true,
})
