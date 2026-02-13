# Dev Environment Setup

macOS 一键配置开发环境：Neovim + Tmux + Fish Shell + 现代 CLI 工具。

基于 [craftzdog/dotfiles-public](https://github.com/craftzdog/dotfiles-public) 配置，包含个人定制。

## 一键安装

```bash
git clone https://github.com/coderhzy/setup-neovim.git
cd setup-neovim
./install.sh
```

安装完成后，编辑 `~/.config/fish/config.fish` 添加你的 API 密钥。

## 包含内容

| 工具 | 说明 |
|------|------|
| **Alacritty** | GPU 加速终端 + Coolnight 主题 + Nerd Font |
| **Neovim** | LazyVim + craftzdog 配置 + solarized-osaka 主题 |
| **Tmux** | 前缀键 `` ` `` + Tokyo Night 主题 + 会话自动保存恢复 |
| **Fish Shell** | 语法高亮 + 自动建议 + 现代 CLI 别名 |
| **CLI 工具** | eza, zoxide, bat, fd, fzf, ripgrep, lazygit, fnm |

## 快捷键速查

### Neovim

| 按键 | 操作 | 按键 | 操作 |
|------|------|------|------|
| `;f` | 查找文件 | `;r` | 全局搜索代码 |
| `gd` | 跳转定义 | `Ctrl+o` | 跳回 |
| `Space+ft` | 浮动终端 | `Space+tv/th` | 分屏终端 |
| `Space+gg` | LazyGit | `Space+e` | 文件树 |
| `sv / ss` | 垂直/水平分屏 | `sh/sl/sj/sk` | 切换窗口 |
| `Alt+hjkl` | 调整窗口大小 | `Tab/Shift+Tab` | 切换 Tab |

### Tmux（前缀键 `` ` ``）

| 按键 | 操作 | 按键 | 操作 |
|------|------|------|------|
| `` ` + \| `` | 垂直分屏 | `` ` + - `` | 水平分屏 |
| `` ` + h/j/k/l `` | 切换面板 | `` ` + c `` | 新建窗口 |
| `` ` + d `` | 脱离会话 | `` ` + z `` | 全屏面板 |

## 与 craftzdog 原版的差异

| 文件 | 变更 |
|------|------|
| `keymaps.lua` | 新增 `Alt+hjkl` 调整窗口、`Space+tv/th` 分屏终端、修复终端 Ctrl+C |
| `options.lua` | shell 改为 `fish` |
| `editor.lua` | close-buffers 改为 `Space+bh/bu` |
| `ui.lua` | 移除 snacks.nvim 的 `keys = {}` |

## 自动同步上游

GitHub Action 每周自动检查 craftzdog 的最新配置，有更新时会创建 PR 供你审核合并。

## 目录结构

```
├── install.sh              # 一键安装脚本
├── alacritty/              # Alacritty 配置 → ~/.config/alacritty/
├── nvim/                   # Neovim 配置 → ~/.config/nvim/
├── tmux/.tmux.conf         # Tmux 配置 → ~/.tmux.conf
└── fish/config.fish        # Fish 配置 → ~/.config/fish/config.fish
```
