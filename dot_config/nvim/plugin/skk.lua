vim.pack.add({
	"https://github.com/kjuq/skkelua.nvim",
})

local map = require("utils").map
local set_hl = require("utils").set_hl

local skkelua = require("skkelua")

local dicDir = "~/.local/share/skk"
local e = vim.fn.expand
skkelua.config({
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
	indicator = {
		alwaysShown = false,
		fadeOutMs = 0,
	},
})

skkelua.register_kanatable("rom", {
	["z<Space>"] = { "\u{3000}", "" },
	[","] = { "、", "" },
	["."] = { "。", "" },
	["jk"] = "escape",
})

map({ "<C-j>", "<Plug>(skkelua-toggle)", modes = { "i", "c" } })

set_hl("SkkeluaIndicatorEiji", { link = "DraculaSelectionInverse" })
set_hl("SkkeluaIndicatorZenkaku", { link = "DraculaPinkInverse" })
set_hl("SkkeluaIndicatorHira", { link = "DraculaGreenInverse" })
set_hl("SkkeluaIndicatorKata", { link = "DraculaCyanInverse" })
set_hl("SkkeluaIndicatorHankata", { link = "DraculaPurpleInverse" })
set_hl("SkkeluaIndicatorAbbrev", { link = "DraculaRedInverse" })
