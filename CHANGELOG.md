# Changelog

All notable changes to this Hyprland dotfiles setup are documented here.

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

[Unreleased]: https://github.com/MoKaif/dotfiles/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/MoKaif/dotfiles/releases/tag/v0.1.0
