# nox's dotfiles — Hyprland / kitty / fish

> **Repo:** `git@github.com:MoKaif/dotfiles.git` · lives at `~/dotfiles`, symlinked into `~/.config`.
> Change history: [CHANGELOG.md](CHANGELOG.md) · current version: [VERSION](VERSION).

## Layout

```
~/dotfiles/
├── .config/
│   ├── hypr/          → ~/.config/hypr      (Hyprland)
│   ├── kitty/         → ~/.config/kitty     (terminal)
│   ├── fish/          → ~/.config/fish      (interactive shell)
│   └── starship.toml  → ~/.config/starship.toml
├── docs/              (notes, not symlinked)
├── CHANGELOG.md
└── VERSION
```

Each entry is symlinked into place, so editing `~/.config/hypr/hyprkeys.conf` edits the repo directly.

### Re-creating the symlinks (fresh machine)

```sh
git clone git@github.com:MoKaif/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/.config/hypr         ~/.config/hypr
ln -s ~/dotfiles/.config/kitty        ~/.config/kitty
ln -s ~/dotfiles/.config/fish         ~/.config/fish
ln -s ~/dotfiles/.config/starship.toml ~/.config/starship.toml
```

## ⚠️ Shell layout — read before changing

**bash is the login shell on purpose. Do not `chsh` to fish.**

The desktop has **no display manager**. It boots via this chain:

```
agetty --autologin nox  →  bash (login)  →  ~/.bash_profile  →  exec start-hyprland
```

`start-hyprland` is Hyprland's official watchdog launcher. Fish does not read `~/.bash_profile`,
so making fish the login shell would silently break this and leave you without a desktop on boot.

**fish is the interactive shell**, launched by kitty (`shell /usr/bin/fish` in `kitty.conf`).
That gives fish everywhere you actually type, with the boot chain untouched.

Environment lives in two places by design: `~/.bashrc` (login/session env, inherited by Hyprland
and everything it spawns) and `.config/fish/config.fish` (re-declares the same PATH/env so fish is
correct standalone too). Keep them in sync.

## Terminal stack

| Tool | Role |
|---|---|
| `kitty` | terminal — rice-matched pink/dark, transparent for Hyprland blur |
| `fish` | interactive shell — autosuggestions + syntax highlighting built in |
| `starship` | prompt — Arch logo, dir + git left, language modules right |
| `eza` / `bat` | `ls` / `cat` replacements (aliased) |
| `fzf` | fuzzy find — `ctrl-r` history, `ctrl-t` files, `alt-c` cd |
| `zoxide` | smarter `cd` — `z <partial>` |
| `yazi` | file manager — `y`, or `yy` to cd where you quit |
| `btop` | system monitor (aliased to `top`) |

## Maintenance workflow

Every change is versioned ([SemVer](https://semver.org)) and pushed:

1. **Edit** the relevant config (via `~/.config/...` or `~/dotfiles/...` — same files).
2. **Reload & verify:** `hyprctl reload` for Hyprland; `exec fish` or a new kitty window for shell changes.
3. **Bump [`VERSION`](VERSION)** — PATCH for tweaks/fixes, MINOR for new keybinds/tools/modules, MAJOR for restructures.
4. **Log it** under a new version heading in [`CHANGELOG.md`](CHANGELOG.md).
5. **Commit, tag, push:**
   ```sh
   git add -A
   git commit -m "vX.Y.Z: <what changed>"
   git tag vX.Y.Z
   git push origin main --tags
   ```

---

## Hyprland reference

### 1) What was configured
- `~/.config/hypr/hyprland.conf` now sources:
  - `/home/nox/.config/hypr/hyprtheme.conf`
  - `/home/nox/.config/hypr/hyprkeys.conf`
  - `/home/nox/.config/hypr/hyprautostart.conf`
- `hyprtheme.conf` contains minimal transparency, blur, dwindle, animations.
- `hyprkeys.conf` contains:
  - `SUPER+Return` → kitty
  - `SUPER+B` → firefox
  - `SUPER+Q` → killactive
  - `SUPER+F` → toggle floating
  - `SUPER+R` → wofi launcher
  - arrow direction movement
  - special workspace scratchpad
  - multimedia keys
- `hyprautostart.conf` autostarts waybar/dunst/nm-applet/wallpaper cycle.
- Waybar is configured for CPU, RAM, network, bluetooth, music, power, wallpaper.
- Dynamic wallpaper script: `~/.config/hypr/scripts/wallpaper-cycle.sh`.
- `~/.config/waybar/scripts/powermenu.sh` created for power menu.

## 2) Quick tests
- Run:
  - `hyprctl reload`
  - `pkill -USR1 waybar` (or restart waybar)
  - `~/.config/hypr/scripts/wallpaper-cycle.sh`
- Check `hyprctl info` output
- Check `~/.config/hypr/hyprland.log` if exists

## 3) Keybind troubleshooting (SUPER+Return, etc.)
1. Make sure config is loaded:
   - `cat ~/.config/hypr/hyprland.conf | grep -E "source|mainMod"`
2. Verify keymap has `SUPER`:
   - `setxkbmap -query`
3. Validate bind by dispatch command:
   - `hyprctl dispatch exec kitty` (should open terminal)
   - if this works, keybind rule parsing might be wrong.
4. Check window manager status:
   - `hyprctl info` for active monitor/layout.
5. Use `logs`:
   - `journalctl --user -u hyprland -f` (or system logs for hyprland service).
6. Ensure no other desktop config overrides (e.g., starship/rofi etc.).

## 4) Known common issues
- `~` in `source` can fail in some Hyprland versions: absolute path is now used.
- `SUPER` can conflict with local keyboard layout; use `SUPERL` if required.
- `SUPER+Return` command may require `kitty` is in $PATH. Verify with `which kitty`.

## 5) Fix strategy
1. If keys still non-functional, temporarily configure a hard key in `hyprland.conf`:
   - `bind = SUPER, Return, exec, xterm` (or `urxvt`)
   - then reload and test.
2. If still broken, show first 50 lines of `~/.config/hypr/hyprland.conf` and current bind file.
3. Confirm you are in the same Hyprland session path (sometimes separate config dir loaded in `~/.config/hypr` vs `~/.config/hyprland`).

## 6) Keep this handy
- backup:
  - `cp -r ~/.config/hypr ~/.config/hypr.bak`
  - `cp -r ~/.config/waybar ~/.config/waybar.bak`
- roll back by swapping from the `.bak` copies.
