set -e

echo "Initializing Critical System Components..."
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/hypr/HyprLand_Scripts"
sudo cp "$HOME/Arch-Hyprland/HyprLand_ConfigFiles/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
sudo cp "$HOME/Arch-Hyprland/HyprLand_Scripts/hypr_ToggleOpacity.sh" "$HOME/.config/hypr/HyprLand_Scripts/hypr_ToggleOpacity.sh"
sudo pacman -S --noconfirm xdg-desktop-portal-hyprland
sudo pacman -S --noconfirm polkit-kde-agent
sudo pacman -S --noconfirm qt5-wayland qt6-wayland
sudo pacman -S --noconfirm dunst
sudo pacman -S --noconfirm brightnessctl
sudo pacman -S --noconfirm pamixer
sudo pacman -S --noconfirm jq


sudo reboot now