Config = {}

function Config.new()
	return {
		goalAngle = 0,
		goalMag = 127,
		selectedItem = 1,
		dist_button_enabled = false,
		dist_button_dist_moved_save = 0,
		dist_button_ignore_y = false,
		dist_button_axis_x = 0,
		dist_button_axis_y = 0,
		dist_button_axis_z = 0,
		strain_button_always = false,
		strain_button_target_strain = true,
		strain_button_left = true,
		strain_button_right = false,
		strain_button_dyaw = false,
		strain_button_arctan = false,
		strain_button_controls = false,
		strain_button_reverse_arc = false,
		strain_button_arctanstart = 0,
		strain_button_arctanr = 1.0,
		strain_button_arctand = 0.0,
		strain_button_arctann = 10,
		strain_button_arctanexp = 0,
		strain_button_highmag = false,
		set_rng_mode_value = false,
		set_rng_mode_index = true,
		swimming = false,
	}
end				

function Config.makeSet(count)
	configs = {}
	for i = 1, count do
  		table.insert(configs, Config.new())
	end
	return configs
end

function Config._saveConfig(config)
	config.goalAngle = Settings.goalAngle
	config.goalMag = Settings.goalMag
	config.selectedItem = Settings.Layout.Button.selectedItem
	config.dist_button_enabled = Settings.Layout.Button.dist_button.enabled
	config.dist_button_dist_moved_save = Settings.Layout.Button.dist_button.dist_moved_save
	config.dist_button_ignore_y = Settings.Layout.Button.dist_button.ignore_y
	config.dist_button_axis_x = Settings.Layout.Button.dist_button.axis.x
	config.dist_button_axis_y = Settings.Layout.Button.dist_button.axis.y
	config.dist_button_axis_z = Settings.Layout.Button.dist_button.axis.z
	config.strain_button_always = Settings.Layout.Button.strain_button.always
	config.strain_button_target_strain = Settings.Layout.Button.strain_button.target_strain
	config.strain_button_left = Settings.Layout.Button.strain_button.left
	config.strain_button_right = Settings.Layout.Button.strain_button.right
	config.strain_button_dyaw = Settings.Layout.Button.strain_button.dyaw
	config.strain_button_arctan = Settings.Layout.Button.strain_button.arctan
	config.strain_button_controls = Settings.Layout.Button.strain_button.controls
	config.strain_button_reverse_arc = Settings.Layout.Button.strain_button.reverse_arc
	config.strain_button_arctanstart = Settings.Layout.Button.strain_button.arctanstart
	config.strain_button_arctanr = Settings.Layout.Button.strain_button.arctanr
	config.strain_button_arctand = Settings.Layout.Button.strain_button.arctand
	config.strain_button_arctann = Settings.Layout.Button.strain_button.arctann
	config.strain_button_arctanexp = Settings.Layout.Button.strain_button.arctanexp
	config.strain_button_highmag = Settings.Layout.Button.strain_button.highmag
	config.set_rng_mode_value = Settings.Layout.Button.set_rng_mode.value
	config.set_rng_mode_index = Settings.Layout.Button.set_rng_mode.index
	config.swimming = Settings.Layout.Button.swimming
end

function Config._loadConfig(config)
	Settings.goalAngle = config.goalAngle
	Settings.goalMag = config.goalMag
	Settings.Layout.Button.selectedItem = config.selectedItem
	Settings.Layout.Button.dist_button.enabled = config.dist_button_enabled
	Settings.Layout.Button.dist_button.dist_moved_save = config.dist_button_dist_moved_save
	Settings.Layout.Button.dist_button.ignore_y = config.dist_button_ignore_y
	Settings.Layout.Button.dist_button.axis.x = config.dist_button_axis_x
	Settings.Layout.Button.dist_button.axis.y = config.dist_button_axis_y
	Settings.Layout.Button.dist_button.axis.z = config.dist_button_axis_z
	Settings.Layout.Button.strain_button.always = config.strain_button_always
	Settings.Layout.Button.strain_button.target_strain = config.strain_button_target_strain
	Settings.Layout.Button.strain_button.left = config.strain_button_left
	Settings.Layout.Button.strain_button.right = config.strain_button_right
	Settings.Layout.Button.strain_button.dyaw = config.strain_button_dyaw
	Settings.Layout.Button.strain_button.arctan = config.strain_button_arctan
	Settings.Layout.Button.strain_button.controls = config.strain_button_controls
	Settings.Layout.Button.strain_button.reverse_arc = config.strain_button_reverse_arc
	Settings.Layout.Button.strain_button.arctanstart = config.strain_button_arctanstart
	Settings.Layout.Button.strain_button.arctanr = config.strain_button_arctanr
	Settings.Layout.Button.strain_button.arctand = config.strain_button_arctand
	Settings.Layout.Button.strain_button.arctann = config.strain_button_arctann
	Settings.Layout.Button.strain_button.arctanexp = config.strain_button_arctanexp
	Settings.Layout.Button.strain_button.highmag = config.strain_button_highmag
	Settings.Layout.Button.set_rng_mode.value = config.set_rng_mode_value
	Settings.Layout.Button.set_rng_mode.index = config.set_rng_mode_index
	Settings.Layout.Button.swimming = config.swimming
end

function Config.load(id)
	Config._saveConfig(Config.Configs[Config.SelectedConfig])
	Config.SelectedConfig = id
	Config._loadConfig(Config.Configs[Config.SelectedConfig])
end

function Config.reset()
	Config._loadConfig(Config.DefaultConfig)
end

Config.Configs = Config.makeSet(8)
Config.DefaultConfig = Config.new()
Config.SelectedConfig = 1

for id, config in ipairs(Config.Configs) do
	name = "config" .. id
	if Settings.Hotkeys[name] == nil then
		Settings.Hotkeys[name] = {}
	end
	table.insert(Buttons, {
		name = name,
		type = ButtonType.button,
		text = " " .. id,
		box = {
			Drawing.Screen.Width + 5 + 21 * (id - 1),
			Drawing.Screen.Height - 28 - 22,
			16,
			22
		},
		enabled = function()
			return true
		end,
		pressed = function()
			return Config.SelectedConfig == id
		end,
		onclick = function(self)
			Config.load(id)
		end
	})
end

resetConfigButtonName = "configreset"
if Settings.Hotkeys[resetConfigButtonName] == nil then
	Settings.Hotkeys[resetConfigButtonName] = {}
end
table.insert(Buttons, {
	name = resetConfigButtonName,
	type = ButtonType.button,
	text = "  Reset",
	box = {
		Drawing.Screen.Width + 5 + 21 * (#Config.Configs),
		Drawing.Screen.Height - 28 - 22,
		44,
		22
	},
	enabled = function()
		return true
	end,
	pressed = function()
		return false
	end,
	onclick = function(self)
		Config.reset()
	end
})