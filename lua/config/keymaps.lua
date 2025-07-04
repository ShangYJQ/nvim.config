vim.keymap.set("i", "<C-q>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-q>", ":q!<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-z>", ":undo<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-x>", "dd", { noremap = true, silent = true })
vim.keymap.set("n", "<C-z>", ":undo<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-c>", "Y", { noremap = true, silent = true })
vim.keymap.set("n", "<C-v>", "p", { noremap = true, silent = true })

vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })

vim.keymap.set("n", "<S-j>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-k>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-c>", ":bp <BAR> bd #<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- vim.keymap.set("n", "<S-s>", ":lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "d", "\"_d", { noremap = true, silent = true })
vim.keymap.set("v", "d", "\"_d", { noremap = true, silent = true })

-- which-key key maps
local whick_key = {

    { "<leader>r",  group = "Autorun" },
    { "<leader>rr", "<cmd>Autorun<CR>",                    desc = "Run your code" },
    { "<leader>rd", "<cmd>Autogdb<CR>",                    desc = "Use cgdb to debug your cpp code" },
    { "<leader>ra", "<cmd>Autoaddtest<CR>",                desc = "Add running test" },
    { "<leader>rt", "<cmd>Autoruntest<CR>",                desc = "Run your code using test" },
    { "<leader>rx", "<cmd>Autodeltest<CR>",                desc = "Del all json test" },

    { "<leader>m",  group = "Cmake-tools" },
    { "<leader>mg", "<cmd>CMakeGenerate<CR>",              desc = "CMake generate" },
    { "<leader>mr", "<cmd>CMakeQuickRun<CR>",              desc = "CMake run" },
    { "<leader>mb", "<cmd>CMakeBuild<CR>",                 desc = "CMake build" },
    { "<leader>ms", "<cmd>CMakeQuickStart<CR>",            desc = "CMake quick start" },

    { "<leader>x",  "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },

    {
        "<leader>w",
        function()
            vim.lsp.buf.code_action()
        end,
        desc = "Fix your code"
    },
    {
        "<leader>s",
        function()
            require("persistence").select()
        end,
        desc = "Select session",
    },
    { "<leader>e", "<cmd>Neotree toggle<CR>",             desc = "Explorer", },
    { "<leader>f", "<cmd>Format<CR>",                     desc = "Format your code", },
    { "<leader>t", "<cmd>ToggleTerm direction=float<CR>", desc = "Open float term", },
}

-- set llm key maps
local llm_keys = {
    { "<leader>a",  group = "AI Tools" },
    { "<leader>ac", mode = "n",        "<cmd>LLMSessionToggle<cr>",            desc = "Open ai session" },
    { "<leader>at", mode = "n",        "<cmd>LLMAppHandler Translate<cr>",     desc = "AI Translate" },
    { "<leader>ae", mode = "x",        "<cmd>LLMAppHandler CodeExplain<cr>",   desc = "AI code explain" },
    { "<leader>at", mode = "x",        "<cmd>LLMAppHandler WordTranslate<cr>", desc = "AI word translate" },
    { "<leader>aa", mode = "x",        "<cmd>LLMAppHandler Ask<cr>",           desc = "AI ask and apply" },
    {
        "<leader>am",
        mode = "n",
        function()
            require("llm.common.api").ModelsPreview()
        end,
        desc = "Change model"
    }
}

if vim.env.LLM_KEY ~= "" and vim.env.LLM_KEY ~= nil then
    table.insert(whick_key, llm_keys)
end

require("which-key").add(whick_key)
