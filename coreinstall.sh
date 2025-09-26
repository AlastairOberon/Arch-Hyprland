set -e

echo "Initializing Critical System Components..."
sudo pacman -S --noconfirm xdg-desktop-portal-hyprland
sudo pacman -S --noconfirm polkit-kde-agent

HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
LINE_POLKIT="exec-once=/usr/lib/polkit-kde-authentication-agent-1"

grep -qxF "$LINE_POLKIT" "$HYPR_CONF" || echo "$LINE_POLKIT" >> "$HYPR_CONF"

sudo pacman -S --noconfirm qt5-wayland qt6-wayland
sudo pacman -S --noconfirm dunst

LINE_DUNST="exec-once=/usr/bin/dunst"

grep -qxF "$LINE_DUNST" "$HYPR_CONF" || echo "$LINE_DUNST" >> "$HYPR_CONF"

sudo reboot now