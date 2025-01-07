#!/bin/bash

green="\033[38;2;0;255;0m"
no_col="\033[0m"

function install() {
    tool_="$1"
    if command -v $tool_ &> /dev/null; then
        echo "$tool_ is already installed, skipping"
        return
    fi
    sudo pacman -S --needed $tool_ --noconfirm
}

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
install nvidia
install nvidia-utils
install nvidia-prime
install amd_ucode
install okular
install vulkan-icd-loader
install lib32-vulkan-icd-loader
install xf86-video-amdgpu
install lib32-vulkan-radeon
install lib32-amdvlk


echo -e "${green}Miscellaneous Tools${no_col}"
# Miscellaneous Tools & Utilities
install zettlr
install figlet
install terminator
install vim
install emacs
install git
install docker
install sleuthkit
install 7zip
install krita
install lshw
install inxi
install mpv
install net-tools
install radeontop
install rclone
install ufw
install whois
install wikiman
install xz
install blender
install gimp
install krita
install darktable
install code
install dhclient
install ffmpeg
install feh
install foot
install lf
install brightnessctl
install qemu
install termdown
install thunderbird
install tree
install tor
install wireshark-qt
install wofi
install htop
install tmux

