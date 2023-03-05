zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
#
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

source ~/.fzf/key-bindings.zsh
source ~/.fzf/completion.zsh

alias vim='nvim'

bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line
bindkey -e

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh


autoload -Uz compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
alias k=kubectl

export KUBECONFIG='/etc/rancher/k3s/k3s.yaml'
export EDITOR=vim
