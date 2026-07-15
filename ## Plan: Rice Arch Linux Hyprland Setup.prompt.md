## Plan: Rice Arch Linux Hyprland Setup

TL;DR
- Use current base config at ~/.config/hypr/hyprland.conf and reference pack at ~/.config/hypr/references/dionysus/dotfiles.
- Build modular config with base, theming, keybind, workspace, statusbar, and animation modules.
- Validate with incremental launches and `hyprctl` / `waybar` reloads.

Steps
1. Discovery (done): existing config is already rich and includes dwindle + animations + keybinds. Reference has extra augments (auto-start, workspace scripts, EWW, etc.).
2. Clarify key deliverables with user: desired theme (Catppuccin/etc), workspace count, primary apps, animation preferences, and feature list (statusbar metrics, scratchpad, app rules, etc.).
3. Create config scaffold:
   - ~/.config/hypr/hyprland.conf (source include files)
   - ~/.config/hypr/hyprcore.conf (global col/border/gaps/inputs)
   - ~/.config/hypr/hyprkeys.conf (keybinds + pseudo/specialworkspaces)
   - ~/.config/hypr/hyprautostart.conf (exec-once programs)
   - ~/.config/hypr/hyprworkspaces.conf (workspace persistence/rules)
   - ~/.config/hypr/hyprwindowrules.conf
4. Build theme assets:
   - colors file with Catppuccin or custom palette
   - Waybar config in ~/.config/waybar/config and style.css
   - optional rofi/wofi/theme and background script
5. Add scripts:
   - power menu, screenshots, audio/mic, brightness, network toggles
   - workspace indicator and app-launch helpers for waybar custom modules
6. Workflow polish:
   - Additional keybind groups for app launch, moving windows, layout toggles.
   - Layout tuning for dwindle and master (pseudotile, preserve split)
   - animation tuning (curves and durations)
   - blur and transparency thresholds (decoration section)
7. QA and rollout:
   - Local backup existing config.
   - `hyprctl reload` + inspect events via `hyprctl activewindow`/`hyprctl workspaces`.
   - `waybar` restart using `pkill -USR1 waybar` or `hyprctl dispatch exec waybar &`.
   - test all binds and scripts.
8. Document final setup in noxarch.md with install and customization notes.

Relevant files
- ~/.config/hypr/hyprland.conf
- ~/.config/hypr/references/dionysus/dotfiles/hypr/hyprland.conf
- ~/.config/hypr/references/dionysus/dotfiles/waybar/config
- ~/.config/hypr/references/dionysus/dotfiles/waybar/style.css
- ~/.config/hypr/references/dionysus/dotfiles/hypr/scripts/...

Verification
1. Ensure `hyprland` boots and fallback to existing base if config errors.
2. `hyprctl info` and `waybar --log-level=debug` show no errors.
3. Keybind tests (mod+T, mod+E, mod+1..0, mod+S + scratchpad, multimedia keys, togglefloating).
4. UI theme match and animation smooth.
5. Blocker capture: app-specific windowrule behavior.

Decisions
- Keep one “reference style” root and gradually merge to avoid breakage.
- Start with minimal working set first; add advanced modules second.

Further considerations
1. Decide if the final setup prefers `rofi` or `wofi` as menu; we can support both.
2. Confirm if `theming` should include `hyprpaper` dynamic wallpaper.
3. Determine if external programs (eww/cava) are needed now or optional.
