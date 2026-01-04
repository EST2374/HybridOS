#!/bin/bash

echo "Updating system..."
sudo pacman -Syu --noconfirm

# Pacman Stuff
echo "Installing core dependencies..."
sudo pacman -S --needed --noconfirm \
  hyprland \
  hypridle \
  hyprlock \
  uwsm \
  waybar \
  alacritty \
  nautilus \
  grim \
  slurp \
  networkmanager \
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
  xdg-desktop-portal-kde \
  polkit-kde-agent \
  dunst \
  pipewire \
  pipewire-pulse \
  wireplumber \
  pavucontrol \
  ttf-font-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols-common \
  sddm \
  qt6-svg \
  qt6-virtualkeyboard \
  qt6-multimedia-ffmpeg \
  plasma-desktop

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
  nmgui-bin \
  wayfreeze-git

SHARE_PATH="$HOME/.local/share/HybridOS"
CONFIG_PATH="$HOME/.config/hybridOS"

# Copy Repo to local share
echo "Setting up HybridOS directories..."
mkdir -p $SHARE_PATH
cp -r ./* $SHARE_PATH

# Copy configs to .configs
echo "Deploying config files..."
mkdir -p $HOME/.config
cp -r ./config/* $HOME/.config

# Copy bashrc and bash_profile
echo "Setting up bash profiles..."
cp ./default/bash/bashrc $HOME/.bashrc
cp ./default/bash/bash_profile $HOME/.bash_profile

# Copy apps and icons
echo "Copying default icons and desktop apps"
mkdir -p $HOME/.local/share/applications/icons
cp ./applications/icons/* $HOME/.local/share/applications/icons
./applications/walker/walker_kde-2-desktop
./applications/discord/discord-2-desktop

mkdir -p $HOME/.config/hybridOS/themes/
for theme in "$SHARE_PATH/themes"/*/; do
  if [ -d "$theme" ]; then
    dir=$(basename "$theme")
    ln -nsf "$SHARE_PATH/themes/$dir" "$CONFIG_PATH/themes/$dir"
  fi
done

mkdir -p $CONFIG_PATH/current/
ln -nsf $CONFIG_PATH/themes/default $CONFIG_PATH/current/theme
ln -nsf $CONFIG_PATH/current/theme/backgrounds/a-logo-with-white-text.png $CONFIG_PATH/current/background

mkdir -p $CONFIG_PATH/logos/
cp ./logo.txt $CONFIG_PATH/logos

# Binaries executable machen
echo "Setting permissions for custom scripts..."
if [ -d "$SHARE_PATH/bin" ]; then
  chmod +x "$SHARE_PATH/bin"/*
fi

echo "Installation complete! Please restart/reboot your session."
