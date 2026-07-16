# Changelog

All notable changes to these dotfiles (Hyprland, kitty, fish, starship) are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

> **Versioning policy** (MAJOR.MINOR.PATCH):
> - **MAJOR** — breaking reorganisation (repo restructure, moving to `~/dotfiles` + symlinks, removing/renaming config files others depend on).
> - **MINOR** — new capability: new keybinds, new config module, new script, autostart additions.
> - **PATCH** — tweaks & fixes: value changes, typo/comment fixes, small corrections that don't add features.
>
> **Workflow for every change** (see [README](README.md#maintenance-workflow)):
> 1. Make the config change.
> 2. Bump `VERSION` and add an entry under a new version heading below.
> 3. `git add -A && git commit` with a clear message.
> 4. `git tag vX.Y.Z` and `git push origin main --tags`.

## [Unreleased]

_Nothing yet._

## [1.1.0] — 2026-07-16

Fish now applies over SSH, which is where the machine is actually used (Claude Code and general work
are run over SSH from Windows Terminal). v1.0.0 scoped fish to kitty, which missed that entirely.

### Added
- **fish handoff for interactive logins** in `.bash_profile`: an interactive login shell (i.e. SSH,
  or any TTY other than tty1) `exec`s into fish. The login shell stays bash, so the boot chain is
  untouched — no `chsh`, no password needed.
- `.bashrc` and `.bash_profile` are now tracked in the repo and symlinked into `~`. `.bash_profile`
  is load-bearing for both the desktop boot and the SSH shell, so it shouldn't have been unversioned.
- README: table of every entry point (tty1 / SSH / kitty / scp / Claude Code) and which shell each
  one lands in.

### Notes — why this is safe
Guards on the fish block, verified by test:
- `$- == *i*` (interactive only) — `ssh host <cmd>`, scp, rsync and **Claude Code's tool shell**
  (non-login + non-interactive, `$-` = `hmtBc`) all stay in bash.
- The tty1 `exec start-hyprland` block sits **above** the fish block and never returns, so a desktop
  boot cannot fall through into fish.
- `FISH_LAUNCHED` guard prevents any re-exec loop.
- Failure mode is safe: an interactive bash does not exit when `exec` fails, so a broken fish leaves
  you in bash rather than locking you out of SSH.

## [1.0.0] — 2026-07-16

Promoted from a hypr-only config into a real dotfiles repo, and added a full terminal stack.

### Changed — BREAKING
- **Repo moved from `~/.config/hypr` to `~/dotfiles`**, with configs symlinked back into `~/.config`.
  Configs now live under `.config/<app>/`; notes moved to `docs/`. All moves used `git mv`, so file
  history is preserved (`git log --follow`).
- `.gitignore` patterns un-anchored so they still match after the move.
- `starship.toml` moved from `~/.config/starship/starship.toml` — a path starship never reads, so it
  had been dormant and doing nothing — to `~/.config/starship.toml`, where it actually loads.
- Starship accents retuned from blue/cyan to the rice pink palette (directory `#f2a1bd`,
  git branch `#c99ade`, git status `#e8a5c0`, time `#958f90`).

### Added
- **kitty config** (`.config/kitty/kitty.conf`) — kitty had no config at all and ran stock defaults.
  CaskaydiaCove Nerd Font 11, rice pink/dark palette (bg `#161013`, fg `#f8dbe4`),
  `background_opacity 0.85` for Hyprland's blur, powerline tabs, split/tab/opacity keybinds,
  and `shell /usr/bin/fish`.
- **fish config** (`.config/fish/config.fish`) — rice-matched syntax colours, eza/bat/git aliases,
  `starship`/`zoxide`/`fzf` init, rice-themed fzf using `fd` as its engine, fish-native OpenClaw
  completions, plus `yy` (yazi cd-on-quit) and `mkcd` helpers.
- Terminal tooling installed: `fish`, `starship`, `zoxide`, `eza`, `bat`, `fd`, `ripgrep`, `yazi`,
  `btop`, `jq`, `chafa`, `tldr`, `neovim`, `luarocks`.
- README: repo layout, symlink re-creation steps, terminal stack table, and a prominent warning
  about the login-shell / boot-chain constraint.

### Removed
- Dead `exec Hyprland` block from `config.fish`. It bypassed the `start-hyprland` watchdog and was
  inert only because fish wasn't installed — installing fish would have made it a live hazard.
- `conf.d/fish_frozen_theme.fish` and `.bak` leftovers — fish 4.3 migration artifacts whose colours
  are now owned by `config.fish`.

### Notes
- **bash remains the login shell, deliberately.** The desktop boots via
  `agetty --autologin nox → bash → ~/.bash_profile → exec start-hyprland`, and fish never reads
  `.bash_profile` — `chsh`-ing to fish would break the boot. Fish is scoped to kitty instead.
- Dormant configs left untouched: `~/.zshrc`, `~/.oh-my-zsh`, `~/.config/zsh/` (zsh isn't the login
  shell, so none of it loads).
- `matugen` is referenced by `hyprlock/colors.conf` but is **not installed**; those colours are a
  static leftover, not dynamically generated.

## [0.2.0] — 2026-07-16

### Added
- Autostart KDE Connect daemon (`exec-once = kdeconnectd &`) in `hyprautostart.conf`,
  so phone integration is available on login.

## [0.1.0] — 2026-07-16

Initial versioned baseline of the Hyprland config.

### Added
- Git repository initialised in `~/.config/hypr`, tracked at `git@github.com:MoKaif/dotfiles.git`.
- `.gitignore` excluding reference rices (`references/`), generated thumbnails, runtime state
  (`scripts/wallpaper-last.txt`), logs, and backups.
- `CHANGELOG.md` + `VERSION` file and a documented Semantic Versioning workflow.
- **Keybinds:** `SUPER + SHIFT + 1..5` to move the focused window to a workspace
  (`movetoworkspace`), complementing the existing `SUPER + 1..5` workspace switches.

### Existing (imported at baseline)
- `hyprland.conf` sourcing `hyprtheme.conf`, `hyprkeys.conf`, `hyprautostart.conf`.
- `hyprkeys.conf` — core keybinds (launchers, focus movement, workspaces, scratchpad, multimedia).
- `hyprtheme.conf` — transparency, blur, dwindle layout, animations.
- `hyprautostart.conf` — waybar, dunst, nm-applet, wallpaper cycle.
- `hyprlock/`, `hyprpaper.conf`, `scripts/wallpaper-cycle.sh`, and supporting docs.

[Unreleased]: https://github.com/MoKaif/dotfiles/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/MoKaif/dotfiles/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/MoKaif/dotfiles/compare/v0.2.0...v1.0.0
[0.2.0]: https://github.com/MoKaif/dotfiles/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/MoKaif/dotfiles/releases/tag/v0.1.0
