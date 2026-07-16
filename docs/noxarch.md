🎯 Goal

Create a fully customized, keyboard-first, visually cohesive Hyprland-based desktop using modular dotfiles and AI-assisted configuration.
You can use the reference folder of dotfiles for scripts or features if possible for theming or making modular or other reusablity....
🧩 1. SYSTEM OVERVIEW
Core Stack
Window Manager: Hyprland
Bar: Waybar
Launcher: Wofi 
Terminal: Kitty 
Shell: Zsh + Starship
Notifications: dunst
Audio: PipeWire

🤖 2. AI AGENT ROLE
The AI agent should:
Ask clarifying questions before making changes
Suggest options (with pros/cons)
Generate configs incrementally
Validate before applying
Keep configs modular and readable
Avoid breaking existing workflow
❓ 3. INTERVIEW PHASE (MANDATORY)

AI must ask these before implementation:

🎨 Visual Preferences
Do you prefer minimal / aesthetic / flashy?
Theme preference? (Catppuccin, Gruvbox, Nord, custom)
Transparency + blur? (yes/no)
Rounded corners? (yes/no)
⚡ Workflow
Keyboard-only vs mixed usage?
Preferred keybinding style? (Vim / default / custom)
Workspace count?
Scratchpad needed? (yes/no)
🖥 Apps
Terminal preference?
File manager?
Browser?
Music player?
📊 Status Bar
What info to show?
CPU / RAM / Disk
Battery
Network
Weather
Music
🧠 Advanced Features
Dynamic theming? (wallpaper-based)
AI integration level? (low/medium/high)
Auto-start apps?
🏗 4. IMPLEMENTATION PHASES
Phase 1: Base Setup
Install required packages
Setup Hyprland config
Basic keybindings
Terminal + launcher working
AI Tasks
Generate minimal hyprland.conf
Ensure system boots into Hyprland
Phase 2: UI Layer
Setup Waybar
Apply theme (colors, fonts, icons)
Configure launcher styling
AI Tasks
Generate Waybar config + CSS
Sync colors across components
Phase 3: Workflow Optimization
Workspace rules
Window rules
Scratchpad terminal
Keybinding refinement
AI Tasks
Add workspace bindings
Implement app-to-workspace mapping
Phase 4: System Utilities
Notifications
Clipboard manager
Screenshot tools
Power menu
AI Tasks
Add scripts for:
screenshots
power menu
wifi/bluetooth toggle
Phase 5: Polish
Animations
Blur effects
Opacity rules
AI Tasks
Tune animation speed
Add blur + transparency
Phase 6: Advanced Features
Dynamic theming
AI-assisted config editing
Logging / automation
AI Tasks
Integrate Pywal/Matugen
Create script hooks for theme switching
📁 5. DOTFILES STRUCTURE (Example not strictly)
dotfiles/
├── hypr/
│   └── hyprland.conf
├── waybar/
│   ├── config
│   └── style.css
├── kitty/
├── zsh/
├── scripts/
├── themes/
└── install.sh
🔁 6. ITERATION LOOP

AI should follow:

Ask → clarify requirement
Propose solution
Show diff / config preview
Ask for approval
Apply change
Validate result
Log change
🧪 7. VALIDATION CHECKLIST

After every change, AI must verify:

Hyprland reloads without errors
Waybar launches correctly
Keybindings work
No crashes or freezes
Logs are clean
⚠️ 8. SAFETY RULES

AI must:

Never overwrite configs without backup
Use modular includes where possible
Comment all generated code
Avoid hardcoding paths
Keep configs readable
🧠 9. OPTIONAL ENHANCEMENTS
Git sync for dotfiles
One-command install script
Multi-device sync
Startup dashboard
Integration with personal knowledge system
📌 10. TASK FORMAT (FOR AI)

Every task should follow:

Task:
Questions:
Q1:
Q2:
Plan:
Step 1
Step 2
Files to Modify:
file path
Output Preview:
# config snippet
Apply? (yes/no)
🚀 END GOAL

A fast, beautiful, keyboard-driven Linux environment that:

reflects personal workflow
is fully reproducible
is easy to extend
integrates with AI tooling


## Latest applied changes (auto appended)
- Modular Hyprland files: `hyprtheme.conf`, `hyprkeys.conf`, `hyprautostart.conf`
- Waybar config + style updated with CPU/RAM/Network/Bluetooth/Music/power+wallpaper modules
- Added `wallpaper-cycle.sh` with `wal` support for palette sync
- Added `powermenu.sh` script
- Fixed path includes to absolute `/home/nox/...` to avoid expansion issues

## Next troubleshooting step for keybinds
1. `hyprctl dispatch exec kitty` → if works, keybind module may not executed.
2. `hyprctl reload`.
3. `journalctl --user -f` and search `hyprland` / `waybar` errors.
4. Confirm no key binding errors in `.cache/hypr/hyprland.log` (if exists).
5. Test with simplified bind in `hyprland.conf`:
   - `bind = SUPER, Return, exec, kitty` and reload.

## Quick commands
- `cp -r ~/.config/hypr ~/.config/hypr.bak`
- `cp -r ~/.config/waybar ~/.config/waybar.bak`
- `hyprctl reload`
- `pkill -USR1 waybar`
- `~/.config/hypr/scripts/wallpaper-cycle.sh`
