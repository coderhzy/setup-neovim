local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Disable s alone (prevent accidental substitute when pressing sh/sj/sk/sl quickly)
keymap.set("n", "s", "<Nop>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sl", "<C-w>l", opts)

-- Resize window (Alt+hjkl)
keymap.set("n", "<M-h>", "2<C-w><", opts)
keymap.set("n", "<M-l>", "2<C-w>>", opts)
keymap.set("n", "<M-k>", "2<C-w>+", opts)
keymap.set("n", "<M-j>", "2<C-w>-", opts)

-- Diagnostics
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("craftzdog.lsp").toggleInlayHints()
end)

vim.api.nvim_create_user_command("ToggleAutoformat", function()
	require("craftzdog.lsp").toggleAutoformat()
end, {})

-- Split terminal (bufhidden=hide keeps terminal alive when window closes)
-- jk exits terminal mode (buffer-local, won't affect LazyGit)
local function open_terminal(cmd)
	vim.cmd(cmd)
	vim.bo.bufhidden = "hide"
	vim.keymap.set("t", "jk", "<C-\\><C-n>", { buffer = 0, noremap = true, silent = true })
end
keymap.set("n", "<Leader>tv", function() open_terminal("vsplit | terminal") end, opts)
keymap.set("n", "<Leader>th", function() open_terminal("split | terminal") end, opts)

-- Fix Ctrl+C in terminal mode (send interrupt signal directly)
keymap.set("t", "<C-c>", function()
	local job_id = vim.b.terminal_job_id
	if job_id then
		vim.fn.chansend(job_id, "\x03")
	end
end, { noremap = true, silent = true })
