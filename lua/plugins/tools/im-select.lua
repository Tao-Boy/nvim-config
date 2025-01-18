local default_im_select, default_command = "", ""
if jit.os:lower() == "windows" then
	default_im_select = "1033"
	default_command = "im-select.exe"
  elseif jit.os:lower() == "linux" then
	default_im_select = "keyboard-us"
	default_command = "fcitx5-remote"
end

return {
	"keaising/im-select.nvim",
	event = "InsertEnter",
	opts = {
		default_im_select = default_im_select,
		default_command = default_command,
		set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
		set_previous_events = { "InsertEnter" },
		keep_quiet_on_no_binary = true,
		async_switch_im = true,
	},
}
