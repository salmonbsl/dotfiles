local dracula = {
	background = "#282A36",
	current_line = "#6272A4",
	selection = "#44475A",
	foreground = "#F8F8F2",
	red = "#FF5555",
	orange = "#FFB86C",
	yellow = "#F1FA8C",
	green = "#50FA7B",
	purple = "#BD93F9",
	cyan = "#8BE9FD",
	pink = "#FF79C6",
}
local color = {
	active = dracula.green,
	active_grad = {
		colors = {
			dracula.green,
			dracula.selection,
			dracula.green,
		},
		angle = 45,
	},
	inactive = dracula.background,
}

---- CONFIG ----
hl.config({
	general = {
		border_size = 2,
		col = {
			active_border = color.active,
			inactive_border = color.inactive,
		},
		gaps_out = 10,
	},
	decoration = {
		rounding = 10,
		inactive_opacity = 0.95,
	},
})

---- MONITOR ----
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@144",
	position = "0x0",
	scale = 1,
})

---- STARTUP ----
hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
end)

---- BINDS ----
local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

local dirs = {
	h = "left",
	j = "down",
	k = "up",
	l = "right",
}
for key, dir in pairs(dirs) do
	-- Focus
	hl.bind(mainMod .. " + " .. string.upper(key), hl.dsp.focus({ direction = dir }))

	--Move Window
	hl.bind(mainMod .. " + SHIFT + " .. string.upper(key), hl.dsp.window.move({ direction = dir }))
end

-- Workspace
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ workspace = "+1" }))

-- Move Window to Workspace
hl.bind(mainMod .. " + CTRL + SHIFT + H", hl.dsp.window.move({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + SHIFT + L", hl.dsp.window.move({ workspace = "+1" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
