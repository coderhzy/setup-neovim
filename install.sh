#!/bin/bash
set -e

echo "========================================="
echo "  Dev Environment Setup (macOS)"
echo "  Neovim + Tmux + Fish + CLI Tools"
echo "========================================="

# Get script directory
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# =========================================
# 1. Homebrew
# =========================================
if ! command -v brew &>/dev/null; then
    echo "[1/8] Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "[1/8] Homebrew already installed, updating..."
    brew update
fi

# =========================================
# 2. CLI Tools
# =========================================
echo "[2/8] Installing CLI tools..."
brew install \
    neovim \
    tmux \
    fish \
    eza \
    zoxide \
    bat \
    fd \
    fzf \
    ripgrep \
    lazygit \
    fnm \
    gh \
    git

# =========================================
# 3. Neovim Config
# =========================================
echo "[3/8] Setting up Neovim config..."
if [ -d "$HOME/.config/nvim" ]; then
    echo "  Backing up existing nvim config to ~/.config/nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak.$(date +%s)"
fi
mkdir -p "$HOME/.config"
cp -r "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# =========================================
# 4. Tmux Config
# =========================================
echo "[4/8] Setting up Tmux config..."
if [ -f "$HOME/.tmux.conf" ]; then
    echo "  Backing up existing tmux config"
    cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak.$(date +%s)"
fi
cp "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Install TPM (Tmux Plugin Manager)
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "  Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# =========================================
# 5. Fish Shell Config
# =========================================
echo "[5/8] Setting up Fish shell..."
mkdir -p "$HOME/.config/fish"
if [ -f "$HOME/.config/fish/config.fish" ]; then
    echo "  Backing up existing fish config"
    cp "$HOME/.config/fish/config.fish" "$HOME/.config/fish/config.fish.bak.$(date +%s)"
fi
cp "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"

# Add fish to allowed shells
if ! grep -q "$(which fish)" /etc/shells 2>/dev/null; then
    echo "  Adding fish to /etc/shells (requires sudo)..."
    echo "$(which fish)" | sudo tee -a /etc/shells
fi

# =========================================
# 6. Node.js (via fnm)
# =========================================
echo "[6/8] Setting up Node.js via fnm..."
if command -v fnm &>/dev/null; then
    eval "$(fnm env)"
    fnm install --lts
    fnm default lts-latest
fi

# =========================================
# 7. Neovim Plugins
# =========================================
echo "[7/8] Installing Neovim plugins (this may take a moment)..."
nvim --headless "+Lazy! sync" +qa 2>/dev/null || true

# =========================================
# 8. Tmux Plugins
# =========================================
echo "[8/8] Installing Tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true

# =========================================
# Done
# =========================================
echo ""
echo "========================================="
echo "  Setup Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "  1. Edit ~/.config/fish/config.fish and add your API keys"
echo "  2. Open a new terminal (will auto-enter tmux)"
echo "  3. Run 'nvim' to start coding"
echo ""
echo "Quick reference:"
echo "  Tmux prefix:  \` (backtick)"
echo "  Terminal:      Space+ft (float) | Space+tv/th (split)"
echo "  Find files:    ;f"
echo "  Search code:   ;r"
echo "  Git:           Space+gg"
echo ""
