echo "Updating system..."
sudo pacman -Syu --noconfirm

echo "Installing packages..."
sudo pacman -S --noconfirm vim git wget curl htop

echo "Configuring Git..."
git config --global user.name "AlastairOberon"
git config --global user.email "alastair.gba@gmail.com"

echo "Installing paru..."
git clone https://aur.archlinux.org/paru.git
cd paru || exit
makepkg -si --noconfirm
cd ..
rm -rf paru

echo "Configuring Audio..."
sudo pacman -S --noconfirm pipewire wireplumber

echo "Installing Fonts..."
sudo pacman -S --noconfirm ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd ttf-jetbrains-mono-nerd ttf-jetbrains-mono ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-mono

echo "Installing Display Manager..."
sudo pacman -S --noconfirm sddm
systemctl enable sddm.service

echo "Installing Kitty..."
sudo pacman -S --noconfirm kitty

echo "Installing IDEs..."
paru -S --noconfirm visual-studio-code-bin
sudo pacman -S --noconfirm nano

echo "Installing Compression Utilities..."
sudo pacman -S --noconfirm tar zip
paru -S --noconfirm rar

echo "Hyprland..."
pacman -S --noconfirm hyprland