#!/bin/bash

red="\033[38;2;200;10;100m"
dark_red="\033[38;2;255;0;0m"
green="\033[38;2;10;244;10m"
nc="\033[0m"

declare -a ARG_ARR
declare -a SUDO

RUN_WITH_SUDO="sudo"

ARG_ARR=("$@")
SUDO=("${RUN_WITH_SUDO}" " ")

INSTALL=0

function LOG() {
    local type_="$1"
    local color=
    shift
    case ${type_} in
        info)
            color="$green"
            echo -e "[${color}$type_${nc}]: $@"
            ;;
        error)
            color="$red"
            echo -e "[${color}$type_${nc}]: $@"
            ;;
        fatal)
            color="$dark_red"
            echo -e "[${color}$type_${nc}]: $@"
            exit 1
            ;;
    esac
}

function Install() {
    local msg="$1"
    shift
    declare -a packages
    local packages=("$@")
    LOG info "${msg}"
    if [[ $INSTALL -eq 1 ]]; then
        if ${SUDO[@]}pacman --noconfirm --needed -S ${packages[@]}; then
            LOG info "Success fully installed: ${packages[@]}"
        else
            LOG error "Errors encoutered while installing"
        fi
    else
        echo "pacman -S --noconfirm ${packages[@]}"
    fi
}

function Install_flatpack() {
    local msg="$1"
    shift
    declare -a packages
    local packages=("$@")
    LOG info "${msg}"
    if [[ $INSTALL -eq 1 ]]; then
        if flatpak install ${packages[@]}; then
            LOG info "Success fully installed: ${packages[@]}"
        else
            LOG error "Errors encoutered while installing"
        fi
    else
        echo "flatpak ${packages[@]}"
    fi
}

for (( i=0 ; i < ${#ARG_ARR[@]}; i++ )); do
    arg="${ARG_ARR[$i]}"
    case "${arg}" in
        --install)
            INSTALL=1
            ;;
        -i)
            INSTALL=1
            ;;
    esac
done

echo -e "\n##############    Installing dependencies for Sway config...    ##############\n"

# Core Wayland + Sway tools
Install "Installing Core Wayland + Sway tools" sway swaylock swayidle foot waybar xdg-utils

# Utilities
Install "Installing extra Utilities" grim slurp wf-recorder brightnessctl playerctl libnotify

# Audio & Volume
Install "Installing Audio & Volume" pipewire pipewire-pulse pavucontrol mpv mpv-mpris ffmpeg

# File manager & terminal
Install "Installing File manager & terminal" dolphin konsole foot

# System monitor
Install "Installing System monitor" htop btop atop ctop plasma-systemmonitor

# Rofi/Wofi launchers
Install "Installing Rofi/Wofi launchers" rofi wofi rofi-emoji

# Browsers
Install "Installing Browsers" qutebrowser

# Text-based visualizer
Install "Installing Text-based visualizer" cava figlet cowsay

# autotiling
Install "Installing Python i3ipc for autotiling" python-i3ipc

# Flatpak Easyeffects (optional)
if ! flatpak list | grep -q 'com.github.wwmm.easyeffects'; then
    echo "Installing Easyeffects via Flatpak..."
    # flatpak install -y flathub com.github.wwmm.easyeffects
fi

echo "Done!!"

