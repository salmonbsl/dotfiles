return {
	{
		"https://github.com/akinsho/toggleterm.nvim",
		event = "VeryLazy",
		config = true,
		keys = function()
			local keys = {}

			-- 移行のため一時的に設定
			-- 使わなくなったら消す
			for i = 0, 9 do
				table.insert(keys, {
					"<A-" .. i .. ">",
					function()
						vim.cmd("90" .. i .. "ToggleTerm direction=float")
					end,
					mode = { "n", "i", "x", "t" },
					desc = "Toggle Term " .. i,
				})
			end

			table.insert(keys, {
				"<leader>ta",
				function()
					vim.cmd("TermNew")
				end,
				mode = { "n" },
				desc = "[a]dd New Terminal",
			})

			table.insert(keys, {
				"<leader>tt",
				function()
					vim.cmd("ToggleTermToggleAll")
				end,
				mode = { "n" },
				desc = "[t]oggle All Terminals",
			})

			table.insert(keys, {
				"<C-'>",
				function()
					vim.cmd("ToggleTermToggleAll")
				end,
				mode = { "n", "t" },
				desc = "Toggle All Terminals",
			})

			table.insert(keys, {
				"<leader>tf",
				function()
					vim.cmd("999ToggleTerm direction=float")
				end,
				mode = { "n" },
				desc = "Open [f]loat Terminal",
			})

			return keys
		end,
	},
}
