#!/usr/bin/env bash
# Bootstrap dotfiles across macOS / Arch Linux / Debian-Ubuntu
# Usage: bash bootstrap.sh
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── OS detection ─────────────────────────────────────────────────────────────
if   [[ "$OSTYPE" == "darwin"* ]];        then OS=macos
elif [[ -f /etc/arch-release ]];          then OS=arch
elif [[ -f /etc/debian_version ]];        then OS=debian
else                                           OS=unknown
fi
echo "==> OS: $OS"

has()      { command -v "$1" &>/dev/null; }
has_sudo() { sudo -n true 2>/dev/null; }

# ─── mise (install first — used as peer package manager below) ────────────────
if ! has mise; then
  echo "==> Installing mise..."
  curl https://mise.run | sh
  export PATH="$HOME/.local/bin:$PATH"
fi

# ─── Package install ──────────────────────────────────────────────────────────
# Map package name → binary name for has() checks (only where they differ)
_cmd() {
  case "$1" in
    ripgrep)   echo "rg"    ;;
    neovim)    echo "nvim"  ;;
    git-delta) echo "delta" ;;
    *)       echo "$1"   ;;
  esac
}

pkg() {
  case "$OS" in
    macos)
      # brew is idempotent; let it decide what needs updating
      brew install "$@" 2>/dev/null || true
      ;;
    arch)
      # --needed skips already-installed packages
      has yay && yay -S --needed --noconfirm "$@" || sudo pacman -S --needed --noconfirm "$@"
      ;;
    debian)
      for p in "$@"; do
        has "$(_cmd "$p")" && continue
        { has_sudo && sudo apt-get install -y "$p"; } ||
        { mise use -g "$p" 2>/dev/null && echo "  [mise] $p"; } ||
        echo "  [skip] $p"
      done
      ;;
  esac
}

# ─── Homebrew ────────────────────────────────────────────────────────────────
if [[ "$OS" == macos ]] && ! has brew; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # shellcheck disable=SC1091
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
fi

# ─── Packages ─────────────────────────────────────────────────────────────────
echo "==> Base packages..."
pkg curl wget unzip zsh htop vim tmux git fzf neovim

echo "==> Shell tools..."
pkg sheldon starship yazi

echo "==> Modern CLI tools..."
pkg bat dust fd ripgrep eza zoxide git-delta tldr

# ─── oh-my-tmux ──────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-tmux" ]]; then
  echo "==> Installing oh-my-tmux..."
  git clone https://github.com/gpakosz/.tmux.git "$HOME/.oh-my-tmux"
fi
ln -sf "$HOME/.oh-my-tmux/.tmux.conf" "$HOME/.tmux.conf"

# ─── LazyVim ─────────────────────────────────────────────────────────────────
# Clone the official starter; edit lua/config/ and lua/plugins/ in-place,
# then track those files with: yadm add ~/.config/nvim/lua/config/options.lua
if [[ ! -f "$HOME/.config/nvim/init.lua" ]]; then
  echo "==> Cloning LazyVim starter..."
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
fi

# ─── Symlink dotfiles ─────────────────────────────────────────────────────────
echo "==> Symlinking dotfiles..."
lnk() {
  local src="$DOTFILES/$1" dst="$HOME/$1"
  [[ -e "$src" ]] || return 0
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst" && echo "  → ~/$1"
}

lnk .zshrc
lnk .gitconfig
lnk .tmux.conf.local
lnk .config/sheldon/plugins.toml
lnk .config/yazi

# ─── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo "==> Done! Run: exec zsh"
echo "    First nvim launch will install LazyVim plugins automatically."
