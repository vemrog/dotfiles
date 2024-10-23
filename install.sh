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

# Copy ranger default configuration
ranger --copy-config=all

# Create necessary directories
mkdir -p "$HOME/Pictures"
mkdir -p "$HOME/.config/nvim"

# Copy image files and config files
cp "$REPO_DIR/images/"* "$HOME/Pictures/"
cp -r "$REPO_DIR/config/"* "$HOME/.config/"

# Copy i3 desktop entry for display managers
sudo cp "$REPO_DIR/config/i3.desktop" "/usr/share/xsessions/i3.desktop"

# Copy Neovim configuration
cp -r "$REPO_DIR/nvim/"* "$HOME/.config/nvim/"

# Make scripts executable
chmod +x "$HOME/.config/polybar/launch.sh"
chmod +x "$HOME/.config/rofi/powermenu.sh"
chmod +x "$HOME/.config/rofi/wifi-menu.sh"
chmod +x "$HOME/.config/rofi/layout.sh"

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
