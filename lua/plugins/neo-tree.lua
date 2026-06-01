-- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/defaults.lua
require("neo-tree").setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	popup_border_style = "", -- or "" to use 'winborder' on Neovim v0.11+
	clipboard = {
		sync = "global", -- or "global"/"universal" to share a clipboard for each/all Neovim instance(s), respectively
	},
	enable_git_status = true,
	sources = {
		"filesystem",
		"document_symbols",
	},
	source_selector = {
		winbar = true,
		sources = {
			{ source = "filesystem" },
			{ source = "document_symbols" },
		},
		truncation_character = "…", -- character to use when truncating the tab label
	},
	enable_diagnostics = true,
	open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy" }, -- when opening files, do not use windows containing these filetypes or buftypes
	open_files_using_relative_paths = false,
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
	},
	-- A list of functions, each representing a global custom command
	-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
	-- see `:h neo-tree-custom-commands-global`
	commands = {},
	window = {
		position = "left",
		width = 32,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<2-LeftMouse>"] = "open",
			["l"] = "open",
			["<esc>"] = "cancel", -- close preview or floating neo-tree window
			["P"] = {
				"toggle_preview",
				config = {
					use_float = true,
					use_snacks_image = true,
					use_image_nvim = true,
				},
			},
			["C"] = "close_node",
			["z"] = "close_all_nodes",
			["a"] = {
				"add",
				-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "none", -- "none", "relative", "absolute"
				},
			},
			["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
			["d"] = "delete",
			["r"] = "rename",
			["b"] = "rename_basename",
			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["<C-r>"] = "clear_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["R"] = "refresh",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
			["i"] = "show_file_details",
		},
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_ignored = true, -- hide files that are ignored by other gitignore-like files
			-- other gitignore-like files, in descending order of precedence.
			ignore_files = {
				".neotreeignore",
				".ignore",
				-- ".rgignore"
			},
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				"node_modules",
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				--".gitignored",
				".vitepress",
			},
			always_show_by_pattern = { -- uses glob style patterns
				".env*",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				".DS_Store",
				"thumbs.db",
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		follow_current_file = {
			enabled = true, -- This will find and focus the file in the active buffer every time
			--               -- the current file is changed while the tree is open.
			leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
		},
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			mappings = {
				["h"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["D"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
				["o"] = {
					"show_help",
					nowait = false,
					config = { title = "Order by", prefix_key = "o" },
				},
				["oc"] = { "order_by_created", nowait = false },
				["od"] = { "order_by_diagnostics", nowait = false },
				["og"] = { "order_by_git_status", nowait = false },
				["om"] = { "order_by_modified", nowait = false },
				["on"] = { "order_by_name", nowait = false },
				["os"] = { "order_by_size", nowait = false },
				["ot"] = { "order_by_type", nowait = false },
				-- ['<key>'] = function(state) ... end,
			},
			fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
				["<down>"] = "move_cursor_down",
				["<C-n>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-p>"] = "move_cursor_up",
				["<esc>"] = "close",
				["<S-CR>"] = "close_keep_filter",
				["<C-CR>"] = "close_clear_filter",
				["<C-w>"] = { "<C-S-w>", raw = true },
				{
					-- normal mode mappings
					n = {
						["j"] = "move_cursor_down",
						["k"] = "move_cursor_up",
						["<S-CR>"] = "close_keep_filter",
						["<C-CR>"] = "close_clear_filter",
						["<esc>"] = "close",
					},
				},
				-- ["<esc>"] = "noop", -- if you want to use normal mode
				-- ["key"] = function(state, scroll_padding) ... end,
			},
		},

		commands = {}, -- Add a custom command or override a global one using the same function name
	},

	document_symbols = {
		follow_cursor = true,
		follow_tree_cursor = true, -- Automatically show symbol location when moving cursor in the tree
		client_filters = "first",
		window = {
			mappings = {
				["<cr>"] = "jump_to_symbol",
				-- ["l"] = "jump_to_symbol",
				["l"] = "toggle_node",
				["h"] = "close_node",
				["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
				["d"] = "noop",
				["y"] = "noop",
				["x"] = "noop",
				["p"] = "noop",
				["c"] = "noop",
				["m"] = "noop",
				["a"] = "noop",
				["b"] = "noop",
				["i"] = "noop",
				["T"] = "noop",
				["<C-r>"] = "noop",
				["u"] = "noop",
				["U"] = "noop",
				["/"] = "filter",
				["f"] = "filter_on_submit",
			},
		},
	},
})

local map = vim.keymap.set

map("n", "<leader>e", function()
	require("neo-tree.command").execute({ toggle = true })
end, { silent = true, desc = "Neotree toggle" })
