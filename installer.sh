#!/bin/bash

set -e
sudo -v

# Pacman Stuff
echo "Installing core dependencies..."
sudo pacman -S --needed --noconfirm \
  hyprland \
  hypridle \
  hyprlock \
  zoxide \
  eza \
  fzf \
  bat \
  fastfetch \
  starship \
  bash-completion \
  xdg-utils \
  neovim \
  mise \
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
  ttf-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols \
  ttf-hack \
  ttf-liberation \
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
SDDM_DIR="/usr/share/sddm/themes"
GRUB_DIR="/usr/share/grub/themes"

# Copy Repo to local share
echo "Setting up HybridOS directories..."
mkdir -p $SHARE_PATH
mkdir -p $HOME/.config
cp -r ./* $SHARE_PATH
cp -r ./config/* $HOME/.config

# Copy bashrc and bash_profile
echo "Setting up bash profiles..."
cp ./default/bash/bashrc $HOME/.bashrc
cp ./default/bash/bash_profile $HOME/.bash_profile

# Pacman config
sudo cp ./default/pacman/pacman.conf /etc/pacman.conf

# Copy apps and icons
echo "Copying default icons and desktop apps"
mkdir -p $HOME/.local/share/applications/icons
cp ./applications/icons/* $HOME/.local/share/applications/icons
chmod +x ./applications/walker/walker_kde-2-desktop
chmod +x ./applications/discord/discord-2-desktop
./applications/walker/walker_kde-2-desktop
./applications/discord/discord-2-desktop

# Symlinks and Themes
mkdir -p $HOME/.config/hybridOS/themes/
for theme in "$SHARE_PATH/themes"/*/; do
  if [ -d "$theme" ]; then
    dir=$(basename "$theme")
    ln -nsf "$SHARE_PATH/themes/$dir" "$CONFIG_PATH/themes/$dir"
  fi
done

# Make symlink for current themes and background
mkdir -p $CONFIG_PATH/current/
ln -nsf $CONFIG_PATH/themes/default $CONFIG_PATH/current/theme
ln -nsf $CONFIG_PATH/current/theme/backgrounds/a-logo-with-white-text.png $CONFIG_PATH/current/background

# SDDM and Grub Symlinks and Themes
# SDDM
sudo cp -r ./sddm_themes/* $SDDM_DIR
sudo mkdir -p /etc/sddm.conf.d
sudo ln -nsf $SDDM_DIR/breeze /usr/share/sddm/themes/current_sddm

echo -e "[Theme]\nCurrent=current_sddm" | sudo tee /etc/sddm.conf.d/theme.conf >/dev/null

# GRUB
sudo cp -r ./grub_themes/* $GRUB_DIR
if [ -d "$GRUB_DIR/whitesur" ]; then
  sudo ln -nsf $GRUB_DIR/whitesur $GRUB_DIR/current_grub
  sudo sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/current_grub/theme.txt"|' /etc/default/grub
  sudo grub-mkconfig -o /boot/grub/grub.cfg
else
  echo "Warning: WhiteSur GRUB theme not found in $GRUB_DIR. Skipping GRUB theme update."
fi

# Copy Logo to .config
mkdir -p $CONFIG_PATH/logos/
cp ./logo.txt $CONFIG_PATH/logos

# Make Binaries executable
echo "Setting permissions for custom scripts..."
if [ -d "$SHARE_PATH/bin" ]; then
  chmod +x "$SHARE_PATH/bin"/*
fi

echo "Installation complete! Please restart your PC"
