set -e

PINK='\033[1;35m'    # Bright magenta looks like pink
PURPLE='\033[0;35m'  # Normal purple/magenta
YELLOW='\033[1;33m'  # Bright yellow
RED='\033[0;31m'     # Red (already in your script)
RESET='\033[0m'      # Reset color


echo -e "${YELLOW}Updating Files...${RESET}"
sudo pacman -Syu --noconfirm 

clear

echo -e "${YELLOW}Some Essentials...${RESET}"
sudo pacman -S --noconfirm vim git wget curl htop 

clear 

git config --global user.name "AlastairOberon"
git config --global user.email "alastair.gba@gmail.com"

clear

if command -v yay >/dev/null 2>&1 || command -v paru >/dev/null 2>&1; then
    echo "AUR helper (yay or paru) already installed. Skipping installation..."
else
    echo "No AUR helper detected."
    echo "Choose an AUR helper to install:"
    echo "1) paru"
    echo "2) yay"
    read -rp "Enter choice [1-2]: " choice

    case "$choice" in
        1)
            echo -e "${YELLOW}Installing and Building Paru...${RESET}"
            git clone https://aur.archlinux.org/paru.git
            cd paru || exit
            makepkg -si --noconfirm
            cd ..
            rm -rf paru
            ;;
        2)
            echo -e "${YELLOW}Installing and Building Yay...${RESET}"
            git clone https://aur.archlinux.org/yay.git
            cd yay || exit
            makepkg -si --noconfirm
            cd ..
            rm -rf yay
            ;;
        *)
            echo -e "${RED}Invalid choice. Skipping AUR helper installation.${RESET}"
            ;;
    esac
fi

if command -v yay >/dev/null 2>&1; then
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    AUR_HELPER="paru"
else
    echo -e "${RED}No AUR helper installed. Exiting...${RESET}"
    exit 1
fi

clear

echo -e "${YELLOW}Installing and Initializing Audio Setup${RESET}"
sudo pacman -S --noconfirm pipewire wireplumber blueman

clear

echo -e "${YELLOW}Installing and Initializing Fonts${RESET}"
sudo pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono
#$AUR_HELPER -S --noconfirm ttf-nunito-sans

clear

echo -e "${YELLOW}Installing and Initializing Login Manager${RESET}"
sudo pacman -S --noconfirm sddm
systemctl enable sddm.service --now


clear

echo -e "${YELLOW}Installing Kitty${RESET}"
sudo pacman -S --noconfirm kitty 

clear

echo -e "${YELLOW}Installing and Initializing IEDs${RESET}"
$AUR_HELPER -S --noconfirm vscodium
sudo pacman -S --noconfirm nano

clear

(sudo pacman -S --noconfirm tar zip && $AUR_HELPER -S --noconfirm rar)

clear

echo "Installing Hyprland..."
sudo pacman -S --noconfirm hyprland hyprlock hypridle hyprpaper

clear


mkdir -p "$HOME/.config/hypr" 
mkdir -p "$HOME/.config/hypr/hyprland_hcripts"

sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hyprpaper.conf" "$HOME/.config/hypr/hyprpaper.conf"
$AUR_HELPER -S --noconfirm wlogout

mkdir -p "$HOME/.config/wlogout"
sudo cp "$HOME/Arch-Hyprland/wlogout/layout" "$HOME/.config/wlogout/layout"
sudo cp "$HOME/Arch-Hyprland/wlogout/style.css" "$HOME/.config/wlogout/style.css"
sudo pacman -S --noconfirm xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland dunst brightnessctl pamixer jq

clear

sudo pacman -S --noconfirm rofi
mkdir -p "$HOME/.config/rofi"
sudo cp "$HOME/Arch-Hyprland/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"

$AUR_HELPER -S --noconfirm eww-git


clear

sudo pacman -S --noconfirm cliphist

clear

$AUR_HELPER -S --noconfirm grimblast

clear

$AUR_HELPER -S --noconfirm swww waypaper
mkdir -p "$HOME/Pictures/wallpapers"
sudo cp -r "$HOME/Arch-Hyprland/wallpapers" "$HOME/Pictures/wallpapers"

echo "Do you want to install Zen Browser?"
echo "1) Yes (zen-browser-bin)"
echo "2) Skip"
read -rp "Enter choice [1-2]: " zen_choice

case "$zen_choice" in
    1)
        if [ -n "$AUR_HELPER" ]; then
            $AUR_HELPER -S --noconfirm zen-browser-bin
        else
            echo -e "${RED}No AUR helper found. Cannot install via AUR.${RESET}"
        fi
        ;;
    2)
        echo "Skipping Zen Browser installation."
        ;;
    *)
        echo -e "${RED}Invalid choice. Skipping Zen Browser installation.${RESET}"
        ;;
esac

echo "Theme Picker..."
sudo pacman -S --noconfirm nwg-look
sudo pacman -S --noconfirm qt5ct qt6ct kvantum
clear

read -rp "Reboot now? [y/N]: " reboot_choice
[[ "$reboot_choice" =~ ^[Yy]$ ]] && sudo reboot