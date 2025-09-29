set -e

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

progress_indicator() {
    local pid=$1
    local message=$2
    local i=0
    local spin=(" " "." ".." "...")
    local rows=$(tput lines)

    while kill -0 "$pid" 2>/dev/null; do
        # Move cursor to the bottom line, column 0
        tput cup $((rows-1)) 0
        echo -ne "${YELLOW}${message}${spin[i]}${RESET}  "
        i=$(( (i+1) % 4 ))
        sleep 0.5
    done

    # Final message on the bottom line
    tput cup $((rows-1)) 0
    echo -e "${GREEN}${message}${RESET}  "
}

sudo pacman -Syu --noconfirm &
progress_indicator $! "Updating system"

sudo pacman -S --noconfirm vim git wget curl htop &
progress_indicator $! "Installing Packages"

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
            git clone https://aur.archlinux.org/paru.git
            cd paru || exit
            makepkg -si --noconfirm
            cd ..
            rm -rf paru
            ;;
        2)
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

sudo pacman -S --noconfirm pipewire wireplumber &
progress_indicator $! "Configuring Audio"

clear

(sudo pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono && $AUR_HELPER -S --noconfirm ttf-nunito) &
progress_indicator $! "Installing Fonts"

clear

sudo pacman -S --noconfirm sddm
systemctl enable sddm.service --now


clear

sudo pacman -S --noconfirm kitty &
progress_indicator $! "Installing Kitty"

clear

$AUR_HELPER -S --noconfirm visual-studio-code-bin &
progress_indicator $! "Installing VSCode"
sudo pacman -S --noconfirm nano &
progress_indicator $! "Installing nano"

clear

(sudo pacman -S --noconfirm tar zip && $AUR_HELPER -S --noconfirm rar) &
progress_indicator $! "Installing Compression Utilities"

clear

echo "Installing Hyprland..."
sudo pacman -S --noconfirm hyprland hyprlock hypridle hyprpaper &
progress_indicator $! "Installing Hyprland"

clear


mkdir -p "$HOME/.config/hypr" 
mkdir -p "$HOME/.config/hypr/hyprland_hcripts"

sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hyprland.conf" "$HOME/.config/hypr/hyprland.conf"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
sudo cp "$HOME/Arch-Hyprland/hyprland_configfiles/hypridle.conf" "$HOME/.config/hypr/hypridle.conf"
$AUR_HELPER -S --noconfirm wlogout &
progress_indicator $! "Initializing wlogout"

mkdir -p "$HOME/.config/wlogout"
sudo cp "$HOME/Arch-Hyprland/wlogout/layout" "$HOME/.config/wlogout/layout"
sudo cp "$HOME/Arch-Hyprland/wlogout/style.css" "$HOME/.config/wlogout/style.css"
sudo pacman -S --noconfirm xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland dunst brightnessctl pamixer jq &
progress_indicator $! "Initializing Critical System Components"

clear

sudo pacman -S --noconfirm rofi &
progress_indicator $! "Initializing Rofi"
mkdir -p "$HOME/.config/rofi"
sudo cp "$HOME/Arch-Hyprland/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
#rofi -dump-config > ~/.config/rofi/config.rasi


clear

sudo pacman -S --noconfirm cliphist &
progress_indicator $! "Initializing Cliphist"

clear

$AUR_HELPER -S --noconfirm grimblast &
progress_indicator $! "GrimBlast"

clear

$AUR_HELPER -S --noconfirm swww waypaper &
progress_indicator $! "Initializing Wallpapers"
mkdir -p "$HOME/Pictures/wallpapers"
sudo cp -r "$HOME/Arch-Hyprland/wallpapers" "$HOME/Pictures/wallpapers"

echo "Theme Picker..."
sudo pacman -S --noconfirm nwg-look
sudo pacman -S --noconfirm qt5ct qt6ct kvantum
clear

read -rp "Reboot now? [y/N]: " reboot_choice
[[ "$reboot_choice" =~ ^[Yy]$ ]] && sudo reboot