vim.pack.add({
	"https://github.com/vim-denops/denops.vim",
	"https://github.com/vim-skk/skkeleton",
})

local e = vim.fn.expand
local dicDir = e("~/.local/share/skk")

vim.fn["skkeleton#config"]({
	globalDictionaries = {
		e(dicDir .. "/SKK-JISYO.L"),
		e(dicDir .. "/SKK-JISYO.geo"),
		e(dicDir .. "/SKK-JISYO.jinmei"),
		e(dicDir .. "/SKK-JISYO.okinawa"),
		e(dicDir .. "/SKK-JISYO.propernoun"),
		e(dicDir .. "/SKK-JISYO.station"),
		e(dicDir .. "/SKK-JISYO.law"),
	},
	eggLikeNewline = true,
})
vim.fn["skkeleton#register_kanatable"]("rom", {
	["z<Space>"] = { "\u{3000}", "" },
	[","] = { "、", "" },
	["."] = { "。", "" },
	["jk"] = "escape",
})

vim.keymap.set({ "i", "c" }, "<c-j>", "<Plug>(skkeleton-toggle)", {
	desc = "Toggle SSK",
})
