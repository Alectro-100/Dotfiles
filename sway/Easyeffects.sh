pkill easyeffects

(swaymsg exec flatpak run com.github.wwmm.easyeffects)
NAME=""
while [[ "$NAME" != "Easy Effects" ]]; do
    NAME="$(swaymsg --type get_tree -r | jq -r '.. | objects | select(.app_id == "com.github.wwmm.easyeffects") | .name')"
    sleep 0.01
done

[[ $? -eq 0 ]] && swaymsg '[app_id="com.github.wwmm.easyeffects"] move scratchpad' && {
    notify-send -t 1000 "Successfully moved \"$NAME\" to scratchpad"
    exit 0
}

notify-send -t 1000 "Script didn't work"
