vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/folke/ts-comments.nvim",
})

local ts = require("nvim-treesitter")
ts.setup()
require("nvim-treesitter-textobjects").setup()
require("nvim-ts-autotag").setup()
require("treesitter-context").setup()
require("ts-comments").setup()

local function ts_manager()
	local available = ts.get_available()
	local installed = {}
	for _, lang in ipairs(ts.get_installed("parsers")) do
		installed[lang] = true
	end

	local items = {}
	for i, lang in ipairs(available) do
		items[#items + 1] = {
			idx = i,
			text = lang,
			lang = lang,
			installed = installed[lang] == true,
		}
	end

	table.sort(items, function(a, b)
		if a.installed ~= b.installed then
			return a.installed
		end

		return a.lang < b.lang
	end)

	---@param picker snacks.Picker
	local function targets(picker)
		local selected = picker:selected()

		if #selected == 0 then
			selected = { picker:current() }
		end

		return selected
	end

	---@param picker snacks.Picker
	---@param action "install"|"uninstall"
	local function run(picker, action)
		local selected = targets(picker)

		local langs = vim.tbl_map(function(item)
			return item.lang
		end, selected)

		ts[action](langs):await(function(err)
			vim.schedule(function()
				if err then
					vim.notify(("%s failed: $s"):format(action, table.concat(langs, ", ")), vim.log.levels.ERROR)
					return
				end

				local is_installed = action == "install"
				for _, item in ipairs(selected) do
					item.installed = is_installed
				end

				picker.list:update({ force = true })

				picker:refresh()

				vim.notify(("%s: %s"):format(is_installed and "Installed" or "Uninstalled", table.concat(langs, ", ")))
			end)
		end)
	end

	Snacks.picker({
		title = "Treesitter  [<cr>] Install  [x] Uninstall",
		items = items,
		layout = {
			hidden = { "preview" },
			layout = {
				width = 0.5,
			},
		},
		on_show = function()
			vim.cmd.stopinsert()
		end,
		format = function(item)
			local status
			local hl
			if item.installed then
				status = "● installed"
				hl = "DiagnosticOk"
			else
				status = "○ available"
				hl = "Comment"
			end

			return {
				{ string.format("%-24s", item.lang), "SnacksPickerLabel" },
				{ status, hl },
			}
		end,

		confirm = function(picker, item)
			run(picker, "install")
		end,

		actions = {
			uninstall = function(picker)
				run(picker, "uninstall")
			end,
		},
		win = {
			input = {
				keys = {
					["x"] = { "uninstall", mode = { "n" } },
				},
			},
		},
	})
end

vim.api.nvim_create_user_command("TSInstallPicker", ts_manager, {})

vim.keymap.set("n", "<leader>Mt", ts_manager, {
	desc = "[t]ree-sitter Manager",
})
