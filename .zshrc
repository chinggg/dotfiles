### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
#zinit light-mode for \z-a-bin-gem-mode
    #zinit-zsh/z-a-rust \
    #zinit-zsh/z-a-as-monitor \
    #zinit-zsh/z-a-patch-dl \
    #zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice depth=1
zinit for \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zdharma-continuum/fast-syntax-highlighting \
    light-mode joshskidmore/zsh-fzf-history-search

export HISTFILE=~/.zsh_history
export HISTSIZE=65535
export SAVEHIST=65535
setopt HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY

autoload -Uz compinit
compinit

[[ -f ~/.pub.zsh ]] && source ~/.pub.zsh
[[ -f ~/.me.zsh ]] && source ~/.me.zsh

bindkey -e  # use emacs keymap even $EDITOR=vim
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

eval "$(starship init zsh)"
source /usr/share/nvm/init-nvm.sh

export PATH=$PATH:~/.local/bin:~/.cargo/bin:~/Code/CS143/bin

# opam configuration
[[ ! -r /home/zen/.opam/opam-init/init.zsh ]] || source /home/zen/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

source /usr/share/fzf/key-bindings.zsh
source /etc/profile.d/google-cloud-cli.sh
source /opt/google-cloud-cli/path.zsh.inc
source /opt/google-cloud-cli/completion.zsh.inc
