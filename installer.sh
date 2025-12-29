#!/bin/bash

echo "Updating system..."
sudo pacman -Syu --noconfirm

# Pacman Stuff
echo "Installing core dependencies..."
sudo pacman -S --needed --noconfirm \
  hyprland \
  uwsm \
  waybar \
  alacritty \
  nautilus \
  gvfs \
  flameshot \
  grim \
  slurp \
  networkmanager \
  bluez \
  bluez-utils \
  bluetui \
  power-profiles-daemon \
  git \
  base-devel \
  flatpak \
  go \
  swww \
  gum \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  polkit-kde-agent \
  dunst \
  pipewire \
  pipewire-pulse \
  wireplumber \
  pavucontrol \
  ttf-font-awesome \
  ttf-nerd-fonts-symbols-common \
  sddm \
  qt6-svg \
  qt6-virtualkeyboard \
  qt6-multimedia-ffmpeg

# If yay isnt installed
if ! command -v yay &>/dev/null; then
  echo "Installing yay (AUR helper)..."
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

# AUR Stuff
echo "Installing AUR packages..."
yay -S --noconfirm \
  walker-bin \
  nmgui-bin

# Copy Repo to local share
echo "Setting up HybridOS directories..."
mkdir -p $HOME/.local/share/HybridOS
cp -r ./* $HOME/.local/share/HybridOS

# Copy configs to .configs
echo "Deploying config files..."
mkdir -p $HOME/.config
cp -r ./config/* $HOME/.config

# Copy bashrc and bash_profile
echo "Setting up bash profiles..."
cp ./default/bash/bashrc $HOME/.bashrc
cp ./default/bash/bash_profile $HOME/.bash_profile

# Binaries executable machen
echo "Setting permissions for custom scripts..."
chmod +x $HOME/.local/share/HybridOS/bin/*

echo "Installation complete! Please restart/reboot your session."
