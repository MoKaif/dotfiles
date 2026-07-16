#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# tty1 autologin → start the desktop. MUST stay above the fish block below:
# this execs and never returns, so a tty1 login never reaches fish.
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec start-hyprland
fi

# Interactive login (SSH, or any TTY other than tty1) → hand off to fish.
#
# Why not `chsh -s /usr/bin/fish`? The login shell must stay bash: the desktop
# boots via agetty --autologin → bash → this file → exec start-hyprland, and
# fish never reads ~/.bash_profile. Changing the login shell breaks the boot.
# See ~/dotfiles/README.md.
#
# Guards, in order:
#   $- == *i*     → interactive only. Claude Code's tool shell, scp/rsync/sftp
#                   and `ssh host <cmd>` are non-interactive and stay in bash.
#   FISH_LAUNCHED → prevents any re-exec loop.
#   command -v    → don't exec what isn't installed.
# Failure is safe: an interactive bash does not exit if exec fails, so a broken
# fish leaves you in bash rather than locking you out of SSH.
if [[ $- == *i* ]] && [[ -z "$FISH_LAUNCHED" ]] && command -v fish >/dev/null 2>&1; then
    export FISH_LAUNCHED=1
    exec fish
fi
