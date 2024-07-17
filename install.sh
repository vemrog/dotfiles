#!/bin/bash

# Install necessary packages
sudo pacman -S xorg xorg-xinit i3-gaps kitty ranger rofi neovim polybar nerd-fonts feh zsh lightdm lightdm-gtk-greeter maim xclip dunst ttf-fira-code

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

mkdir -p "$HOME_PICTURES_DIR"
cp "$REPO_PICTURES_DIR/"* "$HOME_PICTURES_DIR/"

cp -r "$REPO_CONFIG_DIR/"* "$CONFIG_DIR/"

# Make scripts executable
chmod +x "$CONFIG_DIR/rofi/powermenu.sh"
chmod +x "$CONFIG_DIR/polybar/launch.sh"

read -p "Do you want to install additional packages? (y/n): " install_extra

if [[ "$install_extra" == "y" || "$install_extra" == "Y" ]]; then
    echo "Installing additional packages..."
    # Add your additional packages here
    sudo pacman -S telegram-desktop firefox blender clang obsidian
    yay -S visual-studio-code-bin
else
    echo "Skipping additional packages installation."
fi

# Install Oh My Zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp ".zshrc" "$HOME/"