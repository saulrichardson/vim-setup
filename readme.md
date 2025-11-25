# Personal dev setup

This repo keeps the bits I actually re-use across machines: Vim config, a reproducible Homebrew bundle, and the Codex CLI config.

## Layout
- `.vimrc` + `.vim/colors/harry_styles.vim` — Vim setup (vim-plug + custom theme).
- `homebrew/Brewfile` — packages exported via `brew bundle dump`.
- `codex/config.toml` — Codex CLI defaults (no secrets inside).
- `scripts/bootstrap.sh` — symlinks dotfiles into `$HOME` and optionally runs `brew bundle`.

## Quick start
```bash
cd ~/projects/github/vim-setup
./scripts/bootstrap.sh
```
The script backs up any existing `~/.vimrc`, `~/.vim`, and `~/.codex/config.toml` with a timestamp suffix before linking.

## Manual notes
- Homebrew: `brew bundle --file "$HOME/projects/github/vim-setup/homebrew/Brewfile"` installs the list; run `brew bundle dump --file homebrew/Brewfile --force` to refresh it after you install/remove packages.
- Vim: set `mapleader` to `,`; FZF on `<leader>p`, NERDTree on `<leader>n`, CoC autocomplete with Tab/Shift-Tab; custom theme loads automatically.
- Codex: the config expects `GITHUB_MCP_PAT` and `CONTEXT7_API_KEY` to exist in your shell env if you want those MCP servers.

## Publish to GitHub
From inside this folder you can create/push the repo (private suggested):
```bash
git init  # already present, ok if it says so
git add .
git commit -m "Add personal dev setup"
gh repo create your-username/personal-dev-setup --private --source . --push
```
Replace the repo name as desired; `gh` will prompt once.
