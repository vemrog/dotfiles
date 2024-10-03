#!/bin/bash

# Store the current directory
REPO_DIR=$(pwd)

# Install necessary packages
sudo pacman -S xorg xorg-xinit i3-wm kitty ranger rofi neovim polybar nerd-fonts feh zsh lightdm lightdm-gtk-greeter maim xclip dunst ttf-fira-code picom ueberzug

# Enable LightDM to start on boot
sudo systemctl enable lightdm

# Install yay AUR helper
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Set up configuration
CONFIG_DIR="$HOME/.config"
REPO_CONFIG_DIR="config"
REPO_PICTURES_DIR="images"
HOME_PICTURES_DIR="$HOME/Pictures"
NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"

ranger --copy-config=all

mkdir -p "$HOME_PICTURES_DIR"
mkdir -p "$NVIM_CONFIG_DIR"

cp "$REPO_PICTURES_DIR/"* "$HOME_PICTURES_DIR/"
cp -r "$REPO_CONFIG_DIR/"* "$CONFIG_DIR/"

# Copy i3 desktop entry
sudo cp "$REPO_CONFIG_DIR/i3.desktop" "/usr/share/xsessions/i3.desktop"

# Copy ~/.xinitrc file
cp "$REPO_CONFIG_DIR/.xinitrc" "$HOME/.xinitrc"

# Make the .xinitrc executable
chmod +x "$HOME/.xinitrc"

if [ -d "$REPO_DIR/nvim" ]; then
    cp -r "$REPO_DIR/nvim/"* "$NVIM_CONFIG_DIR/"
else
    echo "Directory 'nvim' does not exist in the current directory."
fi

# Make scripts executable
chmod +x "$CONFIG_DIR/rofi/powermenu.sh"
chmod +x "$CONFIG_DIR/polybar/launch.sh"

read -p "Do you want to install additional packages? (y/n): " install_extra

if [[ "$install_extra" == "y" || "$install_extra" == "Y" ]]; then
    echo "Installing additional packages..."
    sudo pacman -S kicad ripgrep lazygit bottom python nodejs npm telegram-desktop firefox obsidian keepassxc
    yay -S visual-studio-code-bin gcc-arm-none-eabi libnewlib-arm-none-eabi tree-sitter go-diskusage
else
    echo "Skipping additional packages installation."
fi

# Install Oh My Zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp ".zshrc" "$HOME/"

# Remove the repository directory
echo "Removing the repository directory: $REPO_DIR"
rm -rf "$REPO_DIR"

echo "Setup completed"
