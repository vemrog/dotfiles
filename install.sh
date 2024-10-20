#!/bin/bash

# Store the current directory
REPO_DIR=$(pwd)

# Install yay AUR helper
echo "Cloning yay repository..."
if ! git clone https://aur.archlinux.org/yay.git; then
    echo "Error: Could not clone yay repository."
    exit 1
fi
cd yay
makepkg -si
cd ..
rm -rf yay

# Install packages via pacman
sudo pacman -S --needed xorg xorg-xinit i3-wm kitty ranger rofi neovim polybar nerd-fonts feh zsh lightdm lightdm-gtk-greeter maim xclip dunst ttf-fira-code picom ueberzug polkit-gnome bluez bluez-utils ripgrep lazygit bottom

# Install AUR packages via yay
yay -S --needed tree-sitter go-diskusage bluetuith

# Enable services
sudo systemctl enable lightdm
sudo systemctl enable bluetooth
sudo systemctl enable NetworkManager.service

# Define paths
CONFIG_DIR="$HOME/.config"
REPO_CONFIG_DIR="$REPO_DIR/config"
REPO_PICTURES_DIR="$REPO_DIR/images"
HOME_PICTURES_DIR="$HOME/Pictures"
NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"

# Copy ranger default configuration
ranger --copy-config=all

# Create necessary directories
mkdir -p "$HOME_PICTURES_DIR"
mkdir -p "$NVIM_CONFIG_DIR"

# Copy image files and config files
cp "$REPO_PICTURES_DIR/"* "$HOME_PICTURES_DIR/"
cp -r "$REPO_CONFIG_DIR/"* "$CONFIG_DIR/"

# Copy i3 desktop entry for display managers
sudo cp "$REPO_CONFIG_DIR/i3.desktop" "/usr/share/xsessions/i3.desktop"

# Copy Neovim configuration
cp -r "$REPO_DIR/nvim/"* "$NVIM_CONFIG_DIR/"

# Make scripts executable
chmod +x "$CONFIG_DIR/polybar/launch.sh"
chmod +x "$CONFIG_DIR/rofi/powermenu.sh"
chmod +x "$CONFIG_DIR/rofi/wifi-menu.sh"

# Ask to install additional packages
read -p "Do you want to install additional packages? (y/n): " install_extra

if [[ "$install_extra" == "y" || "$install_extra" == "Y" ]]; then
    sudo pacman -S --needed kicad python nodejs npm telegram-desktop firefox obsidian keepassxc
fi

# Install oh-my-zsh
if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
    echo "Error: Could not install oh-my-zsh."
    exit 1
fi

# Copy .zshrc to the home directory
cp "$REPO_DIR/.zshrc" "$HOME/"

# Cleanup
echo "Cleaning up..."
rm -rf "$REPO_DIR"

echo "Installation complete!"
