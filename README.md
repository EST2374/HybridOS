# 🌀 HybridOS Arch Rice

A high-performance, script-driven Arch Linux setup built on **Hyprland** and **Walker**.

## 🌟 Why is this Walker implementation specific?

Unlike standard application launchers, the **HybridOS Walker Menu** acts as a centralized OS management layer. 

### Key Customizations:
* **Integrated Package Management**: Custom functions (`pac_add`, `yay_install`, `flatpak_add`) wrap standard commands into a "Floating Terminal Presentation" mode.
* **Dynamic Power Profiles**: It queries `power-profiles-daemon` to allow real-time switching between Performance, Balanced, and Power-saver modes directly from the UI.
* **TUI & Web Integration**: Built-in logic to launch terminal-based utilities (TUI) or specific documentation wikis (Arch Wiki, Hyprland Wiki, etc.) via a unified search bar.
* **Smart Installers**: Contains pre-defined logic for complex installs like `waydroid`, `vesktop`, and even local scripts like `tetris-install`.

## 🛠 Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/EST2374/HybridOS.git
   cd HybridOS
