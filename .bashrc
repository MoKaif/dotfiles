#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=$PATH:/home/nox/.spicetify
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$HOME/.npm-global/bin:$PATH"

# OpenClaw Completion
source "/home/nox/.openclaw/completions/openclaw.bash"
export QT_QPA_PLATFORMTHEME=qt5ct
export PATH="$HOME/.local/bin:$PATH"
