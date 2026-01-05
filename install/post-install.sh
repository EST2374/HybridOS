#!/bin/bash

CONFIG_PATH="$HOME/.config/hybridOS"

echo -e "\n--- VERIFICATION ---"
[ -L "$CONFIG_PATH/current/theme" ] && echo "✅ Theme Symlink: OK" || echo "❌ Theme Symlink: FAILED"
[ -f "/etc/sddm.conf.d/theme.conf" ] && echo "✅ SDDM Config: OK" || echo "❌ SDDM Config: FAILED"
grep -q "current_grub" /etc/default/grub && echo "✅ GRUB Config: OK" || echo "❌ GRUB Config: FAILED"
