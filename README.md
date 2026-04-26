I am CS PhD student, use yadm to idempotent bootstrap and sync dotfiles across devices:
- new MacBook: install `homebrew` first, then brew install for all
- old personal ArchLinux laptop: `pacman` (sometimes `yay`) for all, quite easy
- ssh server mostly Ubuntu LTS or Debian
  - if has sudo permission, try `apt` install first
  - if no sudo or package not in apt, use `mise` to install at user level

must-have cli programs
```
standard base utils:
curl wget unzip zsh htop vim tmux git fzf

tiny modern cmds:
bat https://github.com/sharkdp/bat#installation
fd https://github.com/sharkdp/fd#installation
ripgrep https://github.com/burntsushi/ripgrep#installation
tlrc

shell/editor with popular config (often need to append zshrc/bashrc):
sheldon https://sheldon.cli.rs/Examples.html
starship https://starship.rs/guide/
yazi https://yazi-rs.github.io/docs/installation (y shell wrapper)
lazyvim https://www.lazyvim.org/installation
oh-my-tmux https://github.com/gpakosz/.tmux
```

personal configs (some can be public, some contain secrets)
```
ssh config for personal/employee server, and private keys!
git config (user, alias, etc)
shell alias (eg. docker, wg vpn)
```

