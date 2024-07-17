#!/bin/bash

# Store the current directory
REPO_DIR=$(pwd)

# Install necessary packages
sudo pacman -S xorg xorg-xinit i3-gaps kitty ranger rofi neovim polybar nerd-fonts feh zsh lightdm lightdm-gtk-greeter maim xclip dunst ttf-fira-code picom

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

ranger --copy-config=all

mkdir -p "$HOME_PICTURES_DIR"
cp "$REPO_PICTURES_DIR/"* "$HOME_PICTURES_DIR/"

cp -r "$REPO_CONFIG_DIR/"* "$CONFIG_DIR/"

# Make scripts executable
chmod +x "$CONFIG_DIR/rofi/powermenu.sh"
chmod +x "$CONFIG_DIR/polybar/launch.sh"

read -p "Do you want to install additional packages? (y/n): " install_extra

if [[ "$install_extra" == "y" || "$install_extra" == "Y" ]]; then
    echo "Installing additional packages..."
    sudo pacman -S telegram-desktop firefox blender obsidian clang cmake keepassxc
    yay -S visual-studio-code-bin gcc-arm-none-eabi libnewlib-arm-none-eabi
else
    echo "Skipping additional packages installation."
fi

# Ask if user wants to change monitor refresh rate
read -p "You want to change the screen resolution and hertz to 1920x1080 - rate 74.-97: " change_refresh_rate

if [[ "$change_refresh_rate" == "y" || "$change_refresh_rate" == "Y" ]]; then
    echo 'xrandr --output HDMI-0 --mode 1920x1080 --rate 74.97' >> ~/.xprofile
    chmod +x ~/.xprofile
    echo "Monitor refresh rate set to 74.97 Hz."
else
    echo "Skipping monitor refresh rate change."
fi

# Install Oh My Zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp ".zshrc" "$HOME/"

# Remove the repository directory
echo "Removing the repository directory: $REPO_DIR"
rm -rf "$REPO_DIR"

echo "Setup completed"