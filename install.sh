set -e

echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing packages..."
sudo pacman -S --noconfirm vim git wget curl htop

clear 

echo "Configuring Git..."
git config --global user.name "AlastairOberon"
git config --global user.email "alastair.gba@gmail.com"

clear

echo "Installing paru..."
if command -v yay >/dev/null 2>&1 || command -v paru >/dev/null 2>&1; then
    echo "✅ AUR helper (yay or paru) already installed. Skipping installation..."
else
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit
    makepkg -si --noconfirm
    cd ..
    rm -rf paru
fi

clear

echo "Configuring Audio..."
sudo pacman -S --noconfirm pipewire wireplumber

clear

echo "Installing Fonts..."
sudo pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono

clear

echo "Installing Display Manager..."
sudo pacman -S --noconfirm sddm
systemctl enable sddm.service

clear

echo "Installing Kitty..."
sudo pacman -S --noconfirm kitty

clear

echo "Installing IDEs..."
paru -S --noconfirm visual-studio-code-bin
sudo pacman -S --noconfirm nano

clear

echo "Installing Compression Utilities..."
sudo pacman -S --noconfirm tar zip
paru -S --noconfirm rar

clear

echo "Installing Hyprland..."
sudo pacman -S --noconfirm hyprland
paru -S --noconfirm hyprlock
paru -S --noconfirm hypridle
clear

echo "Initializing Critical System Components..."
mkdir -p "$HOME/.config/hypr"
mkdir -p "$HOME/.config/hypr/hyprland_hcripts"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
paru -S --noconfirm wlogout

mkdir -p "$HOME/.config/wlogout"
sudo cp "$HOME/Arch-Hyprland/wlogout/layout" "$HOME/.config/wlogout/layout"
sudo cp "$HOME/Arch-Hyprland/wlogout/style.css" "$HOME/.config/wlogout/style.css"
sudo pacman -S --noconfirm xdg-desktop-portal-hyprland
sudo pacman -S --noconfirm polkit-kde-agent
sudo pacman -S --noconfirm qt5-wayland qt6-wayland
sudo pacman -S --noconfirm dunst
sudo pacman -S --noconfirm brightnessctl
sudo pacman -S --noconfirm pamixer
sudo pacman -S --noconfirm jq

clear

echo "Initializing Rofi..."
sudo pacman -S --noconfirm rofi
mkdir -p "$HOME/.config/rofi"
#sudo cp "$HOME/Arch-Hyprland/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
rofi -dump-config > ~/.config/rofi/config.rasi

clear

echo "Initializing Cliphist..."
sudo pacman -S --noconfirm cliphist

clear

echo "Initializing GrimBlast..."
paru -S --noconfirm grimblast

clear

echo "Initializing Wallpapers..."
paru -S --noconfirm swww
paru -S --noconfirm hyprpaper
paru -S --noconfirm waypaper
mkdir -p "$HOME/Pictures/wallpapers"
sudo cp -r "$HOME/Arch-Hyprland/wallpapers" "$HOME/Pictures/wallpapers"

echo "Theme Picker..."
sudo pacman -S -noconfirm nwg-look
sudo pacman -S -noconfirm qt5ct qt6ct kvantum
clear

#echo "Initializing hyprpicker..."
#paru -S --noconfirm hyprpicker


sudo reboot now