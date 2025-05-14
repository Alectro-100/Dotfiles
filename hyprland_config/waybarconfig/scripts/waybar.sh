#!/bin/bash

kill $(pidof waybar)
if [[ $USER == "Zyren" ]]; then
    /usr/bin/waybar -c $HOME/.config/hypr/waybarconfig/config.jsonc -s $HOME/.config/hypr/waybarconfig/style.css &
else
    /usr/bin/waybar &
fi

