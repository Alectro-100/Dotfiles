#!/bin/bash

green="\033[38;2;0;255;0m"
no_col="\033[0m"

X=0
function install() {
    tool_="$1"
    if [[ $X -eq 0 ]]; then
        echo -e "${green}Update FIRST${no_col}"
        sudo pacman -Syyu
        X=1
        return
    fi
    if command -v $tool_ &> /dev/null; then
        echo -e "'${tool_}' already installed, skipping"
        return
    fi
    echo -e "${green}Installing '${tool_}'${no_col}"
    [[ -n "$tool_" ]] && sudo pacman -S --needed "$tool_" --noconfirm
}
install 

echo  -e "${green}Informatin Gathering${no_col}"
# Information Gathering & Reconnaissance Tools
install nmap
install whois
install nikto
#install zaproxy
#install dnsrecon
#install recon-ng
#install amass
#install gobuster
#install sublist3r
#install enum4linux
#install shodan
#install dmitry

echo  -e "${green}Explitation Tools${no_col}"
# Exploitation & Post-Exploitation Tools
install metasploit
#install openvas
#install nessus

echo  -e "${green}Wireless Network tools${no_col}"
# Wireless Network Tools
install aircrack-ng
install reaver
install kismet
#install fluxion
#install airgeddon
install wifite

echo  -e "${green}Password and Cryptography tools${no_col}"
# Password Cracking & Cryptography Tools
install john
install hashcat
install johntheripper
#install cain
#install gpg
install openssl
install cryptsetup

echo -e "${green}Network and System analysis tools${no_col}"
# Network & System Analysis Tools
install tcpdump
#install wireshark-gtk
install ettercap-gtk
#install netdiscover
install mtr
install bettercap
#install arpspoof
install netcat

echo -e "${green}Forensics and Incident Response${no_col}"
# Forensics & Incident Response Tools
#install autopsy
install volatility
#install scalpel
install sleuthkit
install volatility3
#install bulk_extractor
#install dc3dd

echo -e "${green}Reverse Engineering tools${no_col}"
# Reverse Engineering & Debugging Tools
install radare2
install ghidra
install gdb
install llvm
install clang
install base-devel
install strace
install ltrace
#install ollydbg
#install x64dbg

echo -e "${green}Cryptography tools"
# Cryptography & Security Tools
install hashcat
#install steghide
install toilet
install cacafire
install cowsay

echo -e "${green}Graphics related tools${no_col}"
# Graphics Related Packages
install vulkan-devel
install vulkan-tools
# install nvidia
# install nvidia-utils
# install nvidia-prime
# install amd_ucode
install vulkan-tools
install vulkan-devel
install vulkan-icd-loader
install lib32-vulkan-icd-loader
install xf86-video-amdgpu
install lib32-vulkan-radeon

# Install sway (The tiling window manager)

# install sway swaybg swayidle swayimg swaylock swaync

echo -e "${green}Miscellaneous Tools${no_col}"
# Miscellaneous Tools & Utilities
install zettlr
install figlet
install terminator
# install vim
# install git
# install docker
install sleuthkit
install 7zip
# install krita
install lshw
install inxi
install mpv
install net-tools
install radeontop
# install okular
install rclone
install ufw
install whois
install wikiman
# install blender
# install gimp
# install krita
install darktable
# install code
# install dhclient
install ffmpeg
install feh
install imv
install foot
install brightnessctl
install qemu
install termdown
install thunderbird
install tree
install tor
install wireshark-qt
# install wofi
install htop
install tmux
install dust
install yazi
install lazygit
install btop
install xdot
install cpu-x
install mpd ncmpcpp
# install rust rust-src
install psmisc
# install rsyslog
install syslog-ng
install nvtop
install powertop
install wf-recorder
install sysstat
install nmon
install glances
install krusader
install qemu-ndb
install nwg-drawer
