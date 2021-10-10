# global env
export EDITOR=vim

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
    export LESSCHARSET=utf-8

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# fn key
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

alias ls="ls --color"
alias l="ls -lah"
alias o="xdg-open"
alias p="python"
grp() { grep $1 -RIn .; }

alias dcbuild="docker-compose build"
alias dcup="docker-compose up"
alias dcdown="docker-compose down"
alias dps='docker ps --format "{{.ID}} {{.Names}}"'
alias dockps='docker ps --format "{{.ID}} {{.Names}}"'
docksh() { docker exec -it $1 bash; }
udocksh() { docker exec -it -u $(id -u):$(id -g) $1 bash; }
alias http="systemctl start httpd"

export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2"


#export RUSTUP_DIST_SERVER="https://rsproxy.cn"
#export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

alias afl-sys="echo core|sudo tee /proc/sys/kernel/core_pattern; cd /sys/devices/system/cpu; echo performance | sudo tee cpu*/cpufreq/scaling_governor; cd -"

