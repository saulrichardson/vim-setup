#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_SUFFIX="$(date +%Y%m%d%H%M%S)"

link() {
  local source="$1" dest="$2"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    local backup="${dest}.bak.${BACKUP_SUFFIX}"
    echo "Backing up $dest -> $backup"
    mv "$dest" "$backup"
  fi
  mkdir -p "$(dirname "$dest")"
  echo "Linking $dest -> $source"
  ln -s "$source" "$dest"
}

echo "Symlinking vim config..."
link "$REPO_DIR/.vimrc" "$HOME/.vimrc"
link "$REPO_DIR/.vim" "$HOME/.vim"

echo "Symlinking Codex config..."
link "$REPO_DIR/codex/config.toml" "$HOME/.codex/config.toml"

if command -v brew >/dev/null 2>&1; then
  echo "Install/upgrade Homebrew bundle? (y/N)"
  read -r answer
  if [[ "$answer" =~ ^[Yy]$ ]]; then
    brew bundle --file "$REPO_DIR/homebrew/Brewfile"
  else
    echo "Skipped brew bundle."
  fi
else
  echo "Homebrew not found; skipping bundle install."
fi

echo "Done."
