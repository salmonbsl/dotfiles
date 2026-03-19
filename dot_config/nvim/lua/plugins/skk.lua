return {
	{
		"https://github.com/vim-skk/skkeleton",
		dependencies = {
			"vim-denops/denops.vim",
		},
		config = function()
			local e = vim.fn.expand
			vim.fn["skkeleton#config"]({
				globalDictionaries = {
					e("~/dotfiles/resources/skk-dics/SKK-JISYO.L"),
					e("~/dotfiles/resources/skk-dics/SKK-JISYO.geo"),
					e("~/dotfiles/resources/skk-dics/SKK-JISYO.jinmei"),
					e("~/dotfiles/resources/skk-dics/SKK-JISYO.okinawa"),
					e("~/dotfiles/resources/skk-dics/SKK-JISYO.propernoun"),
					e("~/dotfiles/resources/skk-dics/SKK-JISYO.station"),
					e("~/dotfiles/resources/skk-dics/SKK-JISYO.law"),
				},
				eggLikeNewline = true,
			})
			vim.fn["skkeleton#register_kanatable"]("rom", {
				["z<Space>"] = { "\u{3000}", "" },
				[","] = { "、", "" },
				["."] = { "。", "" },
				["jk"] = "escape",
			})
		end,
		keys = {
			{
				"<C-j>",
				mode = { "i", "c" },
				"<Plug>(skkeleton-toggle)",
				desc = "Toggle SKK",
			},
		},
	},
}
