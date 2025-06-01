#!/bin/bash

LOG_COLOR="\033[38;2;255;244;65m"
RED="\033[38;2;255;0;0m"
NC="\033[0m"

command -v pacman >/dev/null 2>&1 || {
    echo "Script is only for Arch"
    echo "pacman is required but not found. Exiting."
    exit 1
}

function LOG() {
    echo -e "[${LOG_COLOR}LOG${NC}]: $1"
}

function ERROR() {
    echo -e "[${RED}ERROR${NC}]: $1"
}

function install() {
    local TOOL="$@"
    LOG "Installing ${TOOL}"
    sudo pacman -S --needed ${TOOL} --noconfirm
    if [ $? -ne 0 ]; then
        ERROR "Error installing ${TOOL}."
        exit 1
    fi
}

function user_input() {
    local MESSAGE="$1"
    echo "$MESSAGE"
    read -r -p "Enter ((y)es/(n)o): " Input
    if [[ "$Input" == "" || "$Input" =~ ^(y|yes)$ ]]; then
        return 0
    else
        return 1
    fi
}

function install_software() {
    LOG "Installing Sway and application launcher (wofi, rofi)"
    install sway swaybg sway-contrib swayidle swayimg swaylock swaync
    install wofi rofi

    install i3blocks i3lock i3status i3status-rust i3-wm
    LOG "Installing Terminals (foot, alacritty, and konsole)"
    install alacritty konsole foot

    LOG "Installing Git, vim, and Neovim"
    install git vim neovim
}

function copy_configs() {

    local MESSAGE=""
    LOG "Copying configuration files..."

    ### Copy sway configuration
    if [ ! -d "$HOME/.config/sway" ]; then
        mkdir -p "$HOME/.config/sway"
        cp -r ../sway_config/* "$HOME/.config/sway/" || {
            ERROR "Failed to copy sway configs"
            exit 1
        }
    else
        MESSAGE="A sway configuration already exists do you want to back it up and copy new config (enter/no)?"
        if user_input "$MESSAGE"; then
            mv "$HOME/.config/sway/config" "$HOME/.config/sway/config.bak"
            cp ../sway_config/config "$HOME/.config/sway/config" || {
                ERROR "Failed to copy sway config"
                exit 1
            }
            cp -r ../sway_config/wallpapers "$HOME/.config/sway/" || {
                ERROR "Failed to copy wallpapers directory"
                exit 1
            }
        fi
    fi

    ### Copy foot configuration
    if [[ ! -f $HOME/.config/foot/foot.ini ]]; then
        mkdir -p "$HOME/.config/foot"
        cp ../sway_config/foot/foot.ini "$HOME/.config/foot/" || {
            ERROR "Failed to copy foot config"
            exit 1
        }
    else
        MESSAGE="A foot configuration already exists do you want to back it up and copy new config (enter/no)?"
        if user_input "$MESSAGE"; then
            mv "$HOME/.config/foot/foot.ini" "$HOME/.config/foot/foot.ini.bak"
            cp ../sway_config/foot/foot.ini "$HOME/.config/foot/foot.ini" || {
                ERROR "Failed to copy foot config"
                exit 1
            }
        fi
    fi

    ### Copying waybar configuration
    if [[ ! -d $HOME/.config/waybar ]]; then
        mkdir -p "$HOME/.config/waybar"
        cp -r ../waybar_config/* "$HOME/.config/waybar/" || {
            ERROR "Failed to copy waybar configs"
            exit 1
        }
    else
        MESSAGE="A waybar configuration already exists do you want to back it up and copy new config (enter/no)?"
        if user_input "$MESSAGE"; then
            mv "$HOME/.config/waybar/style.css" "$HOME/.config/waybar/style.css.bak"
            mv "$HOME/.config/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc.bak"

            cp ../waybar_config/style.css "$HOME/.config/waybar/style.css" || {
                ERROR "Failed to copy waybar config styles.css"
                exit 1
            }
            cp ../waybar_config/config.jsonc "$HOME/.config/waybar/config.jsonc" || {
                ERROR "Failed to copy waybar config config.jsonc"
                exit 1
            }
        fi
    fi

    ### i3 setup
    if [ ! -d "$HOME/.config/i3" ]; then
        mkdir -p "$HOME/.config/i3/" "$HOME/.config/polybar/" "$HOME/.config/alacritty/"
        cp -r ../i3_config/* "$HOME/.config/i3/" || {
            ERROR "Failed to copy i3 configs"
            exit 1
        }
    fi
}


function configure_vim_and_neovim() {
    local MESSAGE=""
    ### Vim Configuration
    if [[ ! -f "$HOME/.vimrc" ]]; then
        cp ../vim_config/vimrc "$HOME/.vimrc" || {
            ERROR "Failed to copy vimrc config"
            exit 1
        }
    else
        MESSAGE="Already a vimrc config file do you want to back it up (enter/no)?"
        if user_input "$MESSAGE" ; then
            mv $HOME/.vimrc $HOME/.vimrc.bak
            cp ../vim_config/vimrc "$HOME/.vimrc" || {
                ERROR "Failed to copy vimrc config"
                exit 1
            }
        fi
    fi
    ### Neovim
    if [[ ! -f "$HOME/.config/nvim/init.vim" ]]; then
        mkdir -p "$HOME/.config/nvim/"
        cp ../neovim_config/init.vim "$HOME/.config/nvim/init.vim" || {
            ERROR "Failed to copy nvim config"
            exit 1
        }
    else
        MESSAGE="Do you want to Overrite the existing .vimrc config (enter/no)?"
        if user_input "$MESSAGE" ; then
            mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.bak
            cp ../neovim_config/init.vim "$HOME/.config/nvim/init.vim" || {
                ERROR "Failed to copy nvim config"
                exit 1
            }
        fi
    fi
    ### Set them up
    command -v curl 1> /dev/null 2>&1 || install curl

    command -v vim 1> /dev/null 2>&1 || install vim
    /usr/bin/vim -c "InstallPlug | :q | :q"
    /usr/bin/vim -c "PlugUpdate | :q | :q"

    command -v nvim 1> /dev/null 2>&1 || install nvim
    /usr/bin/nvim -c "InstallPlug | :q | :q"
    /usr/bin/nvim -c "PlugUpdate | :q | :q"
}

read -r -p "Install the software packages? (y/n): " yn
if [[ $yn =~ ^[Yy]$ ]]; then
    install_software
elif [[ $yn == "" ]]; then
    install_software
elif [[ $yn =~ ^[Nn]$ ]]; then
    ERROR "Installation aborted."
    exit 0
else
    ERROR "Only yes or no."
    exit 1
fi

read -r -p "Copy the configuration files? (y/n): " yn
if [[ $yn =~ ^[Yy]$ ]]; then
    copy_configs
elif [[ $yn == "" ]]; then
    copy_configs
elif [[ $yn =~ ^[Nn]$ ]]; then
    ERROR "Configuration copying aborted."
    exit 0
else
    LOG "Please answer yes or no."
    exit 1
fi

read -r -p "Set up vim and neovim? (y/n)" yn
if [[ $yn =~ ^[Yy]$ ]]; then
    configure_vim_and_neovim
fi

LOG "Setup complete!"

