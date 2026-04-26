# ~/.zshrc

# ─── PATH ────────────────────────────────────────────────────────────────────
path=($HOME/.local/bin $HOME/bin $path)

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ─── Environment ─────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$TTY

# ─── Runtimes ────────────────────────────────────────────────────────────────
(( $+commands[mise] )) && eval "$(mise activate zsh)"

# ─── Plugins ─────────────────────────────────────────────────────────────────
eval "$(sheldon source)"

# ─── Prompt ──────────────────────────────────────────────────────────────────
eval "$(starship init zsh)"

# ─── Zoxide (smarter cd) ─────────────────────────────────────────────────────
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# ─── fzf (Ctrl+R history, Ctrl+T files, Alt+C cd) ────────────────────────────
(( $+commands[fzf] )) && eval "$(fzf --zsh)"

# ─── Completion ──────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit

# ─── History ─────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt hist_ignore_dups hist_ignore_space share_history

# ─── Key bindings ─────────────────────────────────────────────────────────────
bindkey -e
# Up/down: prefix-based history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# ─── Options ─────────────────────────────────────────────────────────────────
setopt glob_dots auto_pushd pushd_ignore_dups no_auto_menu

# ─── Functions ────────────────────────────────────────────────────────────────
autoload -Uz zmv

function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

function y() {
  local tmp cwd
  tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi "$@" --cwd-file="$tmp"
  cwd="$(cat -- "$tmp")"
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd -- "$cwd"
  rm -f -- "$tmp"
}

# ─── Aliases ──────────────────────────────────────────────────────────────────
(( $+commands[nvim] )) && alias v='nvim'
(( $+commands[eza]  )) && alias ll='eza -la --icons' \
                       || alias ll='ls -lAh --color=auto'

alias gs='git status'
alias gd='git diff'

alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'

alias dcbuild="docker-compose build"
alias dcup="docker-compose up"
alias dcdown="docker-compose down"
alias dps='docker ps --format "{{.ID}} {{.Names}}"'
alias dockps='docker ps --format "{{.ID}} {{.Names}}"'
docksh() { docker exec -it $1 bash; }
udocksh() { docker exec -it -u $(id -u):$(id -g) $1 bash; }

alias cld='claude --dangerously-skip-permissions'

# ─── Local (secrets, machine-specific) ───────────────────────────────────────
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
