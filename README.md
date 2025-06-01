# Dotfiles — Arch Linux, Your Way

Welcome to the configuration nexus. This repository houses my complete setup for a modular, keyboard-driven Linux experience. Optimized for **Arch Linux**, tiling window managers, and high-efficiency workflows.

> Note: These dotfiles are tuned for users who know their way around a terminal. No hand-holding, just clean configs and composability.

---

## 📂 Repository Structure

| Directory           | Description |
|---------------------|-------------|
| `ArchAutoSetup/`    | Scripts to bootstrap an Arch system after install. Installs packages, sets up configs, etc.              |
| `hyprland_config/`  | Hyprland configuration: fast, slick, Wayland-native. Comes with launcher scripts and Waybar integration. |
| `i3_config/`        | i3-gaps setup for X11 with kitty terminal config and wallpapers. Classic and snappy.                     |
| `neovim_config/`    | Neovim configuration (`init.vim`) with plugins for LSP, fuzzy finding, theming, etc.                     |
| `scripts/`          | Custom scripts: system info, SSHFS mounts, ProtonDrive sync, journal entries, and more.                  |
| `shell_config/`     | Zsh/Bash configurations: aliases, functions, and startup logic.                                          |
| `sway_config/`      | Sway tiling WM for Wayland. Full theming, wallpapers, and `foot` terminal configs included.              |
| `vim_config/`       | Lightweight Vim setup for non-gui workflow or servers.                                                   |
| `waybar_config/`    | Waybar setup for Sway/Hyprland. Modular JSONC with scripts and styles.                                   |
| `wofi_config/`      | Wofi launcher themes and behavior configs.                                                               |
| `EMPTY`             | (intentionally blank file for first commit — placeholder).                                               |

---

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/ZyrenArch/ConfigFiles.git
   cd ConfigFiles
   ```
2. **Run the Arch Auto Setup (at your own risk)**:
    ```bash
    cd ArchAutoSetup
    chmod +x Arch_Setup.sh
    ./Arch_Setup.sh
    ```
