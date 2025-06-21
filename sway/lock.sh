#!/usr/bin/env bash

PLAYERS="$(playerctl --list-all)"

function set_background() {
    swaylock --daemonize --image "${HOME}/.config/sway/imgs/lock_bg.jpg"
}

function main() {
    local arg1="$1"

    if [[ "${arg1}" == "set_bg" ]]; then
        set_background
        return 0
    fi

    [[ -z "${PLAYERS}" ]] && PLAYERS="NotPlaying"

    IFS=$'\n'; for player in ${PLAYERS}; do
        status_=$(playerctl --player="${player}" status 2>/dev/null)
        if [[ "${status_}" == "Playing" ]]; then
            return 0
        fi
    done

    set_background
    sleep 0.4 && swaymsg 'output * power off'
}

main "$@"
