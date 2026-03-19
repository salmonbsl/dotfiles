local autocmd = require("utils.autocmd")
autocmd.create({ "InsertLeave", "TextChanged" }, {
	pattern = "*",
	command = "silent! write",
})
