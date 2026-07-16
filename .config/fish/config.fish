# fish — interactive shell, used inside kitty.
#
# NOTE: fish is deliberately NOT the login shell.
# The desktop launch chain is:
#   agetty --autologin nox → bash (login) → ~/.bash_profile → exec start-hyprland
# `start-hyprland` is Hyprland's official watchdog launcher. Do not add an
# `exec Hyprland` here and do not `chsh` to fish — that would bypass both
# ~/.bash_profile and the watchdog. The old exec-Hyprland block that used to
# live in this file was removed for exactly that reason.

# ── Environment ───────────────────────────────────────────────────────
# Mostly inherited from bash via Hyprland, but set here too so fish is
# correct even when launched standalone. fish_add_path is idempotent.
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.npm-global/bin
fish_add_path $HOME/.dotnet/tools
fish_add_path $HOME/.spicetify

set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx PAGER less
set -gx MANPAGER 'nvim +Man!'

# bat as the colour-izer for man pages
set -gx MANROFFOPT -c

if not status is-interactive
    exit
end

# ── Interactive-only below ────────────────────────────────────────────
set -g fish_greeting  # no banner

# Colours — rice pink/dark. These override the fish 4.3 migrated defaults
# in conf.d/fish_frozen_theme.fish (conf.d is sourced before config.fish).
set -g fish_color_normal        f8dbe4
set -g fish_color_command       f2a1bd --bold
set -g fish_color_keyword       c99ade
set -g fish_color_quote         f0c674
set -g fish_color_redirection   7fd6d2
set -g fish_color_end           e39ff6
set -g fish_color_error         ff6b8b
set -g fish_color_param         f8dbe4
set -g fish_color_comment       958f90 --italic
set -g fish_color_selection --background=4a2f3a
set -g fish_color_search_match --background=4a2f3a
set -g fish_color_operator      7fd6d2
set -g fish_color_escape        c99ade
set -g fish_color_autosuggestion 5c4a54
set -g fish_color_cwd           f2a1bd
set -g fish_color_user          c99ade
set -g fish_color_host          f8dbe4
set -g fish_pager_color_prefix       f2a1bd --bold
set -g fish_pager_color_completion   f8dbe4
set -g fish_pager_color_description  958f90
set -g fish_pager_color_selected_background --background=4a2f3a

# ── Aliases ───────────────────────────────────────────────────────────
alias ls  'eza --icons --group-directories-first'
alias ll  'eza -l --icons --group-directories-first --git'
alias la  'eza -la --icons --group-directories-first --git'
alias lt  'eza --tree --level=2 --icons --group-directories-first'
alias cat 'bat --style=plain'
alias catn 'bat'
alias grep 'grep --color=auto'
alias df  'df -h'
alias du  'du -h'
alias free 'free -h'
alias top 'btop'
alias vim 'nvim'
alias vi  'nvim'
alias y   'yazi'

# git
alias gs 'git status --short'
alias gd 'git diff'
alias gl 'git log --oneline --graph --decorate -20'
alias ga 'git add'
alias gc 'git commit'
alias gp 'git push'

# ── Tool init ─────────────────────────────────────────────────────────
starship init fish | source
zoxide init fish | source
fzf --fish | source

# fzf: rice-matched colours + fd as the engine
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_DEFAULT_OPTS '--height 45% --layout=reverse --border=rounded \
  --color=bg+:#3a2833,bg:-1,spinner:#f2a1bd,hl:#c99ade \
  --color=fg:#f8dbe4,header:#c99ade,info:#958f90,pointer:#f2a1bd \
  --color=marker:#a8d98a,fg+:#f8dbe4,prompt:#f2a1bd,hl+:#f2a1bd \
  --color=border:#4a2f3a'

# bat theme
set -gx BAT_THEME base16

# OpenClaw completions (fish-native; the bash one in .bashrc can't be used here)
if test -f $HOME/.openclaw/completions/openclaw.fish
    source $HOME/.openclaw/completions/openclaw.fish
end

# ── Functions ─────────────────────────────────────────────────────────
# yazi: cd to the directory you quit in (bound to `y`)
function yy
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set -l cwd (command cat -- "$tmp"); and test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# mkdir + cd
function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end
