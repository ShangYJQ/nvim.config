## 由 `Neovim` v0.12 & `vim.pack` 驱动. 为速度和美观而生.

![界面预览](./screenshots/01.png)

## 环境依赖

1. `Neovim` v0.12+
2. 编译器: `gcc`, `g++`
3. Rust 工具链: `rustc`, `cargo`
4. Node 环境: `bun` （推荐）
5. `tree-sitter-cli`: 确保语法高亮解析正常

# 安装指南

```bash
# 导入配置
git clone https://github.com/ShangYJQ/nvim.config.git ~/.config/nvim
git clone git@github.com:ShangYJQ/nvim.config.git # If use ssh

# 编译安装最新 neovim (NVIM v0.12.1 已经发布 直接包管理安装即可)
git clone --depth 1 https://github.com/neovim/neovim
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/.local/share/neovim" CMAKE_BUILD_TYPE=Release
make install
export PATH="$HOME/.local/share/neovim/bin:$PATH"

# 安装必须依赖
bun i -g tree-sitter-cli
export PATH="$HOME/.bun/bin:$PATH"
```

## 安装语言支持(lsp formatter)

### Arch Linux

#### Lua

```bash
sudo pacman -S lua-language-server stylua
```

#### Rust

```bash
# sudo pacman -S rust-analyzer rust
rustup component add rust-analyzer
```

#### C/C++

```bash
sudo pacman -S clang
```

#### Python

```bash
sudo pacman -S python-ruff
```

#### Bash

```bash
sudo pacman -S bash-language-server shfmt
```

#### Fish

```bash
sudo pacman -S fish-lsp
sudo pacman -S shfmt
```

#### JSON

```bash
bun i -g vscode-langservers-extracted
```

#### Go

```bash
sudo pacman -S gopls go
go install golang.org/x/tools/cmd/goimports@latest
export PATH="$HOME/go/bin:$PATH"
```

#### Zig

```bash
sudo pacman -S zls zig
```

#### ASM

```bash
sudo pacman -S asm-lsp
```

#### TOML

```bash
sudo pacman -S taplo-cli
```

#### CMake

```bash
sudo pacman -S cmake-format
paru -S neocmakelsp-bin
```

#### make

```bash
go install github.com/owenrumney/make-ls/cmd/make-ls@latest
```

#### Markdown/YAML/HTML/CSS

```bash
bun i -g prettier
```

#### XML

```bash
sudo pacman -S libxml2
```

#### haskell

```bash
# 使用 ghcup 安装 haskell 工具链
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
# 安装 formatter
brew install ormolu
```

#### Vue

```bash
bun i -g @vue/language-server
bun i -g @vtsls/language-server
bun i -g unocss-language-server
bun i -g @tailwindcss/language-server
bun i -g vscode-langservers-extracted
```

#### DockerFile

```bash
bun i -g dockerfile-language-server-nodejs
```

#### matlab

> [!NOTE]
> 后续请到 `after/lsp/matlab_ls.lua` 修改 LSP 配置。

```bash
git clone https://github.com/mathworks/MATLAB-language-server.git
cd MATLAB-language-server
npm install
npm run package

```

#### gh_action_ls

```bash
bun i -g gh-actions-language-server
```

## 快捷键

> Leader 键为 `<Space>`

### 通用

| 模式 | 按键                  | 功能                    |
| ---- | --------------------- | ----------------------- |
| i    | `<C-q>`               | 退出插入模式            |
| n    | `<C-q>`               | 退出                    |
| n    | `<C-Q>`               | 强制退出                |
| t    | `<C-q>`               | 退出终端模式            |
| n    | `n` / `N`             | 搜索结果居中显示        |
| n,v  | `d`                   | 删除到黑洞寄存器        |
| n    | `<leader>c`           | 清除搜索高亮            |
| n    | `x`                   | 选中当前行 (Helix 风格) |
| v    | `x`                   | 退出选择                |
| n    | `<S-Up>` / `<S-Down>` | 半页上/下滚动           |
| n    | `<A-k>` / `<A-j>`     | 上/下移动行             |
| n    | `<A-Up>` / `<A-Down>` | 上/下移动行             |
| n    | `gs` / `gl`           | 行首/行尾               |
| n    | `<leader>u`           | 复制整个文件            |
| n    | `<leader>z`           | 切换命令行高度          |

### 窗口管理

| 模式 | 按键                     | 功能                 |
| ---- | ------------------------ | -------------------- |
| n    | `<C-h/j/k/l>`            | 焦点切换 左/下/上/右 |
| n    | `<leader>h/j/k/l`        | 分屏 左/下/上/右     |
| n    | `<C-Up/Down/Left/Right>` | 调整窗口大小         |

### LSP

| 模式 | 按键         | 功能              |
| ---- | ------------ | ----------------- |
| n    | `gd`         | 跳转定义          |
| n    | `gD`         | 跳转声明          |
| n    | `gi`         | 跳转实现          |
| n    | `gr`         | 查找引用          |
| n    | `gy`         | 跳转类型定义      |
| n    | `K`          | 悬浮文档          |
| i    | `<C-k>`      | 签名帮助          |
| n    | `<leader>a`  | 代码操作          |
| n    | `<leader>r`  | 重命名符号        |
| n    | `<leader>D`  | 显示诊断 (含来源) |
| n    | `<leader>y`  | 复制当前诊断      |
| n    | `<leader>Y`  | 复制所有诊断      |
| n    | `<leader>ih` | 切换 inlay hints  |
| n    | `<leader>id` | 切换行内诊断      |

### Telescope

| 模式 | 按键         | 功能                     |
| ---- | ------------ | ------------------------ |
| n    | `<leader>f`  | 查找文件                 |
| n    | `<leader>/`  | 当前缓冲区模糊搜索       |
| n    | `<leader>?`  | 全局内容搜索 (live grep) |
| n    | `<leader>d`  | 诊断列表                 |
| n    | `<leader>s`  | 文档符号                 |
| n    | `<leader>S`  | 工作区符号               |
| n    | `<leader>gh` | Git status               |
| n    | `<leader>w`  | 查找 TODO                |
| n    | `<leader>T`  | 主题切换                 |
| n    | `<leader>n`  | 通知记录                 |

### Git (gitsigns)

| 模式 | 按键         | 功能               |
| ---- | ------------ | ------------------ |
| n    | `]c` / `[c`  | 下/上一个 git hunk |
| n    | `<leader>gb` | 切换 git blame     |
| n    | `<leader>gd` | 行内 diff 预览     |
| n    | `<leader>gr` | 重置 hunk          |

### 文件树 (Neo-tree)

| 模式 | 按键        | 功能                |
| ---- | ----------- | ------------------- |
| n    | `<leader>e` | 切换文件树 (懒加载) |

### 终端 (Sloat)

| 模式 | 按键        | 功能              |
| ---- | ----------- | ----------------- |
| n    | `<leader>t` | 浮动终端 (懒加载) |

### Overseer (任务运行)

| 模式 | 按键         | 功能                  |
| ---- | ------------ | --------------------- |
| n    | `<leader>oo` | 切换任务列表 (懒加载) |
| n    | `<leader>ot` | 运行任务              |
| n    | `<leader>os` | Shell 任务            |
| n    | `<leader>oa` | 任务操作              |

### DAP (调试)

| 模式 | 按键         | 功能          |
| ---- | ------------ | ------------- |
| n    | `<F5>`       | 继续 (懒加载) |
| n    | `<leader>dn` | 单步跳过      |
| n    | `<leader>di` | 单步进入      |
| n    | `<leader>do` | 单步跳出      |
| n    | `<leader>b`  | 切换断点      |
| n    | `<leader>dq` | 退出调试      |

### CPH (竞赛)

| 模式 | 按键        | 功能              |
| ---- | ----------- | ----------------- |
| n    | `<leader>x` | 切换 CPH (懒加载) |

### 编辑增强

| 模式 | 按键            | 功能                  |
| ---- | --------------- | --------------------- |
| n,x  | `s`             | Flash 跳转            |
| n    | `S`             | Flash Treesitter 选择 |
| n,x  | `<S-c>`         | 添加多光标            |
| n,x  | `<leader><S-c>` | 跳过光标              |
| n,x  | `<leader>m`     | 清除多光标            |
| n    | `ma`            | 添加 surround         |
| n    | `md`            | 删除 surround         |
| n    | `mr`            | 替换 surround         |
| n    | `mf`            | 查找 surround         |
| n    | `zx`            | 切换全部折叠          |
| n    | `]t` / `[t`     | 下/上一个 TODO        |
| n    | `[i` / `]i`     | 跳转缩进作用域 顶/底  |

## 结构

```text
├── after
│   └── lsp
│       ├── lua_ls.lua
│       ├── make_ls.lua
│       └── matlab_ls.lua
├── ftplugin
│   └── haskell.lua
├── init.lua
├── lua
│   ├── config
│   │   ├── autocmd.lua
│   │   ├── globals.lua
│   │   ├── init.lua
│   │   ├── keymap.lua
│   │   ├── lsp.lua
│   │   ├── neovide.lua
│   │   ├── options.lua
│   │   └── ui2.lua
│   ├── overseer
│   │   └── template
│   │       └── user
│   │           ├── c_quick_run.lua
│   │           ├── cpp_quick_run.lua
│   │           ├── debug_quick_build.lua
│   │           ├── hs_quick_run.lua
│   │           └── py_quick_run.lua
│   ├── plugins
│   │   ├── blink-cmp.lua
│   │   ├── blink-indent.lua
│   │   ├── blink-pairs.lua
│   │   ├── conform.lua
│   │   ├── cph.lua
│   │   ├── dap
│   │   │   ├── dap-view.lua
│   │   │   ├── dap.lua
│   │   │   └── init.lua
│   │   ├── flash.lua
│   │   ├── gitsigns.lua
│   │   ├── init.lua
│   │   ├── lualine.lua
│   │   ├── mini-files.lua
│   │   ├── mini-indentscope.lua
│   │   ├── mini-surround.lua
│   │   ├── multicursor-nvim.lua
│   │   ├── neo-tree.lua
│   │   ├── nvim-treesitter.lua
│   │   ├── nvim-ts-autotag.lua
│   │   ├── nvim-ufo.lua
│   │   ├── oil.lua
│   │   ├── overseer.lua
│   │   ├── render-markdown.lua
│   │   ├── sloat.lua
│   │   ├── telescope.lua
│   │   ├── themes.lua
│   │   ├── tiny-cmdline.lua
│   │   ├── tiny-inline-diagnostics.lua
│   │   ├── todo-comments.lua
│   │   └── toggleterm.lua
│   └── utlis
│       ├── builder.lua
│       └── lazy.lua
├── nvim-pack-lock.json
├── README.md
├── screenshots
│   └── 01.png
└── snippets
    ├── cmake.json
    ├── cpp.json
    ├── json.json
    ├── lua.json
    ├── markdown.json
    ├── package.json
    └── vue.json
```
