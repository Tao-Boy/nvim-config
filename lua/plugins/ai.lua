---------------------------------------------------------------------------
-- avante.nvim: AI assistant (sidebar chat, inline edits)
---------------------------------------------------------------------------
-- Loaded on first use: one of the <leader>a mappings below or an :Avante* command.
-- The Claude provider reads its API key from $ANTHROPIC_API_KEY (or $AVANTE_ANTHROPIC_API_KEY).
local ready = false
local function setup()
	if ready then
		return
	end
	ready = true
	require("avante").setup({
		provider = "claude",
		providers = {
			claude = {
				model = "claude-opus-5-5",
				context_window = 1000000,
				extra_request_body = { max_tokens = 64000, output_config = { effort = "high" } },
			},
		},
		input = { provider = "snacks" },
		selector = { provider = "snacks" },
		windows = {
			width = 35,
			sidebar_header = { rounded = true },
			edit = { border = "rounded" },
			ask = { border = "rounded" },
		},
	})
end

-- Stand-ins for avante's default mappings (setup replaces them with its own <Plug> ones)
local function api(fn, ...)
	local args = { ... }
	return function()
		setup()
		require("avante.api")[fn](unpack(args))
	end
end
local map = vim.keymap.set
map({ "n", "v" }, "<leader>aa", api("ask"), { desc = "avante: ask" })
map({ "n", "v" }, "<leader>an", api("ask", { new_chat = true }), { desc = "avante: create new ask" })
map("v", "<leader>ae", api("edit"), { desc = "avante: edit" })
map("n", "<leader>ah", api("select_history"), { desc = "avante: select history" })
map("n", "<leader>a?", api("select_model"), { desc = "avante: select model" })
map("n", "<leader>at", function()
	setup()
	require("avante").toggle()
end, { desc = "avante: toggle" })

-- Command stubs: load avante (its plugin/ file defines the real commands), then re-run
local commands = {
	"Avante",
	"AvanteAsk",
	"AvanteBuild",
	"AvanteChat",
	"AvanteChatNew",
	"AvanteClear",
	"AvanteEdit",
	"AvanteHistory",
	"AvanteModels",
	"AvanteSwitchProvider",
	"AvanteToggle",
}
for _, name in ipairs(commands) do
	vim.api.nvim_create_user_command(name, function(opts)
		for _, stub in ipairs(commands) do
			pcall(vim.api.nvim_del_user_command, stub)
		end
		setup()
		if vim.fn.exists(":" .. name) == 2 then
			local range = opts.range > 0 and ("%d,%d"):format(opts.line1, opts.line2) or ""
			vim.cmd(range .. name .. (opts.bang and "! " or " ") .. opts.args)
		end
	end, { nargs = "*", range = true, bang = true, desc = "avante.nvim (not loaded yet)" })
end
