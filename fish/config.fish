# ========================================
# Fish Shell 配置（从 zshrc 迁移）
# ========================================

# Fish 自带语法高亮和自动建议，无需额外插件

# ========================================
# PATH
# ========================================
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.bun/bin
fish_add_path /opt/homebrew/bin

# ========================================
# 环境变量
# ========================================

# Python
alias python /opt/homebrew/bin/python3.10
alias python3 /opt/homebrew/bin/python3.10
alias pip /opt/homebrew/bin/pip3.10
alias pip3 /opt/homebrew/bin/pip3.10

# NVM
set -gx NVM_DIR $HOME/.nvm

# Bun
set -gx BUN_INSTALL $HOME/.bun

# NPM
set -gx NPM_CONFIG_ENGINE_STRICT false

# API Keys（请替换为你自己的密钥）
# set -gx BRAVE_API_KEY "your-key-here"
# set -gx GITHUB_PERSONAL_ACCESS_TOKEN "your-token-here"
# set -gx NOTION_API_KEY "your-key-here"
# set -gx ANTHROPIC_API_KEY "your-key-here"
# set -gx OPENROUTER_API_KEY "your-key-here"
# set -gx GEMINI_API_KEY "your-key-here"

# FZF
set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
if command -q fd
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
end

# ========================================
# 现代化 CLI 工具
# ========================================

# Eza (现代 ls)
if command -q eza
    alias ls "eza --icons=always"
    alias ll "eza -la --icons=always"
    alias lt "eza -T --icons=always"
end

# Zoxide (智能 cd)
if command -q zoxide
    zoxide init fish | source
    alias cd z
end

# Bat (语法高亮 cat)
if command -q bat
    alias cat bat
end

# ========================================
# Claude Code Aliases
# ========================================
alias cc 'claude'
alias cc-c 'claude --continue'
alias cr 'claude --resume'
alias cq 'claude -p'
alias cc-fork 'claude --continue --fork-session'
alias cr-fork 'claude --resume --fork-session'
alias cc-safe 'claude --permission-mode ask'
alias cc-plan 'claude --permission-mode plan'
alias cc-fast 'claude --permission-mode acceptEdits'
alias cc-auto 'claude --dangerously-skip-permissions'
alias cc-skip 'claude --dangerously-skip-permissions'
alias cc-c-skip 'claude --continue --dangerously-skip-permissions'
alias cc-c-auto 'claude --continue --dangerously-skip-permissions'
alias cr-skip 'claude --resume --dangerously-skip-permissions'
alias cr-auto 'claude --resume --dangerously-skip-permissions'
alias cq-skip 'claude -p --dangerously-skip-permissions'
alias cq-auto 'claude -p --dangerously-skip-permissions'
alias cc-c-safe 'claude --continue --permission-mode ask'
alias cc-c-plan 'claude --continue --permission-mode plan'
alias cc-c-fast 'claude --continue --permission-mode acceptEdits'
alias cc-debug 'claude --debug'
alias cc-verbose 'claude --verbose'
alias cc-version 'claude --version'
alias cc-help 'claude --help'
alias cq-json 'claude -p --output-format json'
alias cq-stream 'claude -p --output-format stream-json'
alias cc-review 'claude --permission-mode plan'
alias cc-fix 'claude --permission-mode acceptEdits'

# ========================================
# VS Code Shortcuts
# ========================================
alias vsc code
alias vscode code
alias vs 'code .'
alias vsr 'code -r'
alias vsn 'code -n'
alias vsd 'code --diff'

# ========================================
# OpenCode Shortcuts
# ========================================
alias oc 'opencode -m "xiaoman/claude-sonnet-4-5"'
alias occ 'opencode --continue -m "xiaoman/claude-sonnet-4-5"'
alias ocr 'opencode run -m "xiaoman/claude-sonnet-4-5"'
alias oc-opus 'opencode -m "xiaoman/claude-opus-4-5"'
alias oc-haiku 'opencode -m "xiaoman/claude-haiku-4-5"'

# ========================================
# Codex Shortcuts
# ========================================
alias cx codex
alias cxc 'codex --last'
alias cxr 'codex resume'
alias cxf 'codex fork --last'
alias cxe 'codex exec'
alias cxa 'codex apply'
alias cxrev 'codex review'

# ========================================
# Tmux 自动进入（仅在独立终端中，不在 Neovim/VS Code 内）
# ========================================
if command -q tmux
    and not set -q TMUX
    and not set -q NVIM
    and not set -q VSCODE_TERMINAL
    tmux attach-session -t main 2>/dev/null; or tmux new-session -s main
end

# ========================================
# fnm (Fast Node Manager，替代 NVM)
# ========================================
if command -q fnm
    fnm env | source
end
