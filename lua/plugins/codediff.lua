require("codediff").setup({

	-- Diff view behavior
	diff = {
		layout = "side-by-side", -- Diff layout: "side-by-side" (two panes) or "inline" (single pane with virtual lines)
		filler_text = "╱", -- Repeated filler pattern; use "" for blank alignment rows
		disable_inlay_hints = true, -- Disable inlay hints in diff windows for cleaner view
		max_computation_time_ms = 5000, -- Maximum time for diff computation (VSCode default)
		ignore_trim_whitespace = false, -- Ignore leading/trailing whitespace changes (like diffopt+=iwhite)
		hide_merge_artifacts = false, -- Hide merge tool temp files (*.orig, *.BACKUP.*, *.BASE.*, *.LOCAL.*, *.REMOTE.*)
		original_position = "left", -- Position of original (old) content: "left" or "right"
		conflict_ours_position = "right", -- Position of ours (:2) in conflict view: "left" or "right"
		conflict_result_position = "bottom", -- "bottom" (default): result below diff panes or "center": result between diff panes (three columns)
		conflict_result_height = 30, -- Height of result pane in bottom layout (% of total height)
		conflict_result_width_ratio = { 1, 1, 1 }, -- Width ratio for center layout panes {left, center, right} (e.g., {1, 2, 1} for wider result)
		cycle_next_hunk = true, -- Wrap around when navigating hunks (]c/[c): false to stop at first/last
		cycle_next_file = true, -- Wrap around when navigating files (]f/[f): false to stop at first/last
		cycle_hunks_across_files = false, -- ]c/[c at file boundary hops to first/last hunk of next/prev file (explorer/history)
		jump_to_first_change = true, -- Auto-scroll to first change when opening a diff: false to stay at same line
		highlight_added_deleted_files = false, -- Tint full contents of added, untracked, and deleted files
		highlight_priority = 100, -- Priority for line-level diff highlights (increase to override LSP highlights)
		compute_moves = false, -- Detect moved code blocks (opt-in, matches VSCode experimental.showMoves)
		compact_context_lines = 4, -- Number of context lines around hunks in compact mode
		compact_sync_folds = true, -- Sync fold open/close across panes (mirrors Vim diff mode behavior)
		compact = true, -- Open diffs in compact mode by default (fold unchanged regions; toggle with gc)
	},

	-- Explorer panel configuration
	explorer = {
		position = "bottom", -- "left" or "bottom"
		hidden = false, -- Initial visibility state
		width = 30, -- Width when position is "left" (columns)
		height = 13, -- Height when position is "bottom" (lines)
		auto_refresh = true, -- Auto-refresh file list on focus / git index changes (set false to avoid lag in huge repos; R still refreshes manually)
		indent_markers = true, -- Show indent markers in tree view (│, ├, └)
		initial_focus = "explorer", -- Initial focus: "explorer", "original", or "modified"
		icons = {
			folder_closed = "󰉋", -- Nerd Font folder icon (customize as needed)
			folder_open = "󰝰", -- Nerd Font folder-open icon
		},
		view_mode = "list", -- "list" or "tree"
		flatten_dirs = true, -- Flatten single-child directory chains in tree view
		file_filter = {
			ignore = { ".git/**", ".jj/**" }, -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
		},
		focus_on_select = false, -- Jump to modified pane after selecting a file (default: stay in explorer)
		auto_open_on_cursor = false, -- Rebind j/k/Down/Up in the explorer to also open the file under the cursor
		status_right_margin = 1, -- Trailing cells between status symbol (M/A/D) and right edge; increase if Nerd Font icons clip it
		visible_groups = { -- Which groups to show (can be toggled at runtime)
			staged = true,
			unstaged = true,
			conflicts = true,
		},
	},

	-- History panel configuration (for :CodeDiff history)
	history = {
		position = "bottom", -- "left" or "bottom" (default: bottom)
		width = 40, -- Width when position is "left" (columns)
		height = 15, -- Height when position is "bottom" (lines)
		initial_focus = "history", -- Initial focus: "history", "original", or "modified"
		view_mode = "list", -- "list" or "tree" for files under commits
	},

	-- Keymaps in diff view
	keymaps = {
		view = {
			quit = "q", -- Close diff tab
			toggle_explorer = "<leader>e", -- Toggle explorer visibility (explorer mode only)
			focus_explorer = "<leader>b", -- Focus explorer panel (explorer mode only)
			next_hunk = "]c", -- Jump to next change
			prev_hunk = "[c", -- Jump to previous change
			next_file = "]f", -- Next file in explorer/history mode
			prev_file = "[f", -- Previous file in explorer/history mode
			diff_get = "do", -- Get change from other buffer (like vimdiff)
			diff_put = "dp", -- Put change to other buffer (like vimdiff)
			open_in_prev_tab = "gf", -- Open current buffer in previous tab (or create one before)
			close_on_open_in_prev_tab = false, -- Close codediff tab after gf opens file in previous tab
			toggle_stage = "-", -- Stage/unstage current file (works in explorer and diff buffers)
			stage_hunk = "<leader>hs", -- Stage hunk under cursor to git index
			unstage_hunk = "<leader>hu", -- Unstage hunk under cursor from git index
			discard_hunk = "<leader>hr", -- Discard hunk under cursor (working tree only)
			hunk_textobject = "ih", -- Textobject for hunk (vih to select, yih to yank, etc.)
			show_help = "g?", -- Show floating window with available keymaps
			align_move = "gm", -- Temporarily align moved code blocks across panes
			toggle_layout = "t", -- Toggle between side-by-side and inline layout
			toggle_compact = "gc", -- Toggle compact mode (fold unchanged regions)
		},

		explorer = {
			select = "<CR>", -- Open diff for selected file
			hover = "K", -- Show file diff preview
			refresh = "R", -- Refresh git status
			toggle_view_mode = "i", -- Toggle between 'list' and 'tree' views
			stage_all = "S", -- Stage all files
			unstage_all = "U", -- Unstage all files
			restore = "X", -- Discard changes (restore file)
			toggle_changes = "gu", -- Toggle Changes (unstaged) group visibility
			toggle_staged = "gs", -- Toggle Staged Changes group visibility
			-- Fold keymaps (Vim-style)
			fold_open = "zo", -- Open fold (expand current node)
			fold_open_recursive = "zO", -- Open fold recursively (expand all descendants)
			fold_close = "zc", -- Close fold (collapse current node)
			fold_close_recursive = "zC", -- Close fold recursively (collapse all descendants)
			fold_toggle = "za", -- Toggle fold (expand/collapse current node)
			fold_toggle_recursive = "zA", -- Toggle fold recursively
			fold_open_all = "zR", -- Open all folds in tree
			fold_close_all = "zM", -- Close all folds in tree
		},
		history = {
			select = "<CR>", -- Select commit/file or toggle expand
			toggle_view_mode = "i", -- Toggle between 'list' and 'tree' views
			refresh = "R", -- Refresh history (re-fetch commits)
			-- Fold keymaps (Vim-style, apply to directory nodes only)
			fold_open = "zo", -- Open fold (expand current node)
			fold_open_recursive = "zO", -- Open fold recursively (expand all descendants)
			fold_close = "zc", -- Close fold (collapse current node)
			fold_close_recursive = "zC", -- Close fold recursively (collapse all descendants)
			fold_toggle = "za", -- Toggle fold (expand/collapse current node)
			fold_toggle_recursive = "zA", -- Toggle fold recursively
			fold_open_all = "zR", -- Open all folds in tree
			fold_close_all = "zM", -- Close all folds in tree
		},
		conflict = {
			accept_incoming = "<leader>ct", -- Accept incoming (theirs/left) change
			accept_current = "<leader>co", -- Accept current (ours/right) change
			accept_both = "<leader>cb", -- Accept both changes (incoming first)
			discard = "<leader>cx", -- Discard both, keep base
			-- Accept all (whole file) - uppercase versions
			accept_all_incoming = "<leader>cT", -- Accept ALL incoming changes
			accept_all_current = "<leader>cO", -- Accept ALL current changes
			accept_all_both = "<leader>cB", -- Accept ALL both changes
			discard_all = "<leader>cX", -- Discard ALL, reset to base
			next_conflict = "]x", -- Jump to next conflict
			prev_conflict = "[x", -- Jump to previous conflict
			diffget_incoming = "2do", -- Get hunk from incoming (left/theirs) buffer
			diffget_current = "3do", -- Get hunk from current (right/ours) buffer
		},
	},
})
