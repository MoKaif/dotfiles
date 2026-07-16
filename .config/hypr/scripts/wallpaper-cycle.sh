#!/usr/bin/env bash
set -euo pipefail

WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
[ -d "$WALLPAPER_ROOT" ] || exit 1

catges=$(find "$WALLPAPER_ROOT" -mindepth 1 -maxdepth 1 -type d | shuf -n 1)
if [ -z "$catges" ]; then
  catges="$WALLPAPER_ROOT"
fi

FILE=$(find "$catges" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf -n 1)
[ -n "$FILE" ] || exit 1

hyprctl dispatch wallpaper "$FILE" 0 0

# dynamic palette with pywal / wal
if command -v wal >/dev/null 2>&1; then
  wal -n -i "$FILE"
  # create a tiny waybar style from pywal, then reload waybar
  if [ -f "$HOME/.cache/wal/colors.css" ]; then
    cp "$HOME/.cache/wal/colors.css" "$HOME/.config/waybar/style.css"
  fi
fi

# open wallpaper file path in waybar tooltip tag
echo "$FILE" > "$HOME/.config/hypr/scripts/wallpaper-last.txt"
