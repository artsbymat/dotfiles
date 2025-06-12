# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTCONTROL=ignorespace:ignoredups:erasedups
HISTFILE=~/.bash_history
HISTSIZE=1000000
HISTFILESIZE=1000000

bind 'set completion-ignore-case on'
shopt -s autocd

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias rm='trash'
alias ls='eza --group-directories-first'
alias tree='eza --tree'
alias cat='bat --style=plain --pager=never'
alias '..'='cd ..'
alias '...'='cd ../..'
alias 5173='ngrok http 5173'
alias 4321='ngrok http 4321'
alias 4173='ngrok http 4173'
alias 3000='ngrok http 3000'
alias gtl='git log --graph --all --decorate --oneline'
alias tldrf="tldr --list | fzf --preview 'tldr {1} --color=always' --preview-window=right,70% | xargs tldr"
alias pastefile="curl -F 'file=@-' 0x0.st <"
alias pastecmd="curl -F 'file=@-' 0x0.st"
alias pasteclip="wl-paste | curl -F 'file=@-' 0x0.st"
alias git-artsbymat="git -c user.name='Rahmat Ardiansyah' -c user.email='artsbymat@gmail.com'"
alias git-rahmatardiansyah="git -c user.name='Rahmat Ardiansyah' -c user.email='rahmatardiansyah147@gmail.com'"
alias dfs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
	eval $(ssh-agent)
	ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

source /usr/share/fzf/key-bindings.bash

eval "$(starship init bash)"
