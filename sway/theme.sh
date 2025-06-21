#!/usr/bin/env bash

declare -i num=0

pgrep -f "bash .*$(basename "$0")" | grep -v "^$$" | xargs -r kill

trap 'toggle_theme' SIGUSR1

function toggle_theme() {
    [[ $num -eq 0 ]] && num=1 || num=0
    pkill -x waybar
    if [[ $num -eq 1 ]]; then
        swaymsg output "*" background ~/.config/sway/imgs/dark_1.jpg fill
        waybar -c ~/.config/sway/waybar/config.jsonc -s ~/.config/sway/waybar/dark.css &
        [[ $? -eq 0 ]] && echo "waybar on background"
    else
        swaymsg output "*" background ~/.config/sway/imgs/light_0.jpg fill
        waybar -c ~/.config/sway/waybar/config.jsonc -s ~/.config/sway/waybar/light.css &
        [[ $? -eq 0 ]] && echo "waybar on background"
    fi
}

function main() {
    toggle_theme
    while read -r; do :; done < <(tail -f /dev/null)
}

main "$@"

