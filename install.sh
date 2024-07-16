#!/bin/bash

# Install necessary packages
sudo pacman -S xorg xorg-xinit i3-gaps kitty ranger rofi firefox neovim polybar telegram-desktop nerd-fonts feh git zsh lightdm lightdm-gtk-greeter maim xclip dunst

# Enable LightDM to start on boot
sudo systemctl enable lightdm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Install Visual Studio Code from AUR using yay
yay -S visual-studio-code-bin

# Set up configuration and pictures directories
CONFIG_DIR="$HOME/.config"
REPO_CONFIG_DIR="config"

REPO_PICTURES_DIR="Pictures"
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