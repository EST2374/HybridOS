#!/bin/bash

Confs=('alacritty' 'autostart' 'btop' 'dconf' 'elephant' 'freerdp'
  'go' 'hypr' 'KDE' 'kdedefaults' 'plasma-workspace' 'pulse'
  'qalculate' 'systemd' 'vlc' 'waybar' 'walker')

config_pth=~/.config/

printf "\nStart copying config Files\n\n"
for conf in "${Confs[@]}"; do
  cp -r $config_pth$conf/* ./config/$conf
  printf "%s copied\n" $conf
done

printf "\nOperation done\n"
