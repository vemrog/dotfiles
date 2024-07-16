#!/bin/bash

# Install necessary packages
sudo pacman -S xorg xorg-xinit i3-gaps kitty ranger rofi neovim polybar nerd-fonts feh zsh lightdm lightdm-gtk-greeter maim xclip dunst

# Enable LightDM to start on boot
sudo systemctl enable lightdm

# Install yay AUR helper
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Set up configuration and pictures directories
CONFIG_DIR="$HOME/.config"
REPO_CONFIG_DIR="config"
REPO_PICTURES_DIR="images"
HOME_PICTURES_DIR="$HOME/Pictures"

# Create Pictures directory if it doesn't exist and copy images
mkdir -p "$HOME_PICTURES_DIR"
cp "$REPO_PICTURES_DIR/"* "$HOME_PICTURES_DIR/"

# Copy configuration files to the appropriate directories
cp -r "$REPO_CONFIG_DIR/"* "$CONFIG_DIR/"
cp ".zshrc" "$HOME/"

# Make scripts executable
chmod +x "$CONFIG_DIR/rofi/powermenu.sh"
chmod +x "$CONFIG_DIR/polybar/launch.sh"

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Ask user if they want to install additional packages
read -p "Do you want to install additional packages? (y/n): " install_extra

if [[ "$install_extra" == "y" || "$install_extra" == "Y" ]]; then
    echo "Installing additional packages..."
    # Add your additional packages here
    sudo pacman -S telegram-desktop firefox blender clang
    yay -S visual-studio-code-bin
else
    echo "Skipping additional packages installation."
fi