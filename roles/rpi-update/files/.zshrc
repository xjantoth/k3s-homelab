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


autoload -U colors && colors    # Load colors
autoload -Uz compinit promptinit vcs_info

compinit
promptinit
# ------------------------------------------------------------------------------
# Customize PROMPT
# ------------------------------------------------------------------------------

precmd_vcs_info() {
  vcs_info
}
precmd_functions+=(precmd_vcs_info)
#setopt prompt_subst
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '
#export PROMPT="%F{196}%B%(?..?%? )%b%f%F{117}%2~%f%F{245} %#%f %B\$vcs_info_msg_0_%f%b "
#export RPROMPT="%B\$vcs_info_msg_0_%f%b"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%F{240}%b%u %f %F{237}%r%f'
zstyle ':vcs_info:*' enable git
# This will set the default prompt to the walters theme

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
alias k=kubectl

export KUBECONFIG='/etc/rancher/k3s/k3s.yaml'
export EDITOR=vim
