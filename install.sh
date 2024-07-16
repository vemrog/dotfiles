#!/bin/bash

sudo pacman -S xorg xorg-xinit i3-gaps kitty ranger rofi firefox neovim polybar telegram-desktop nerd-fonts feh git zsh lightdm lightdm-gtk-greeter maim xclip dunst

sudo systemctl enable lightdm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

yay -S visual-studio-code-bin

CONFIG_DIR="$HOME/.config"
REPO_CONFIG_DIR="config"

REPO_PICTURES_DIR="images"
HOME_PICTURES_DIR="$HOME/Pictures"

mkdir -p "$HOME_PICTURES_DIR"

cp "$REPO_PICTURES_DIR/"* "$HOME_PICTURES_DIR/"
cp -r "$REPO_CONFIG_DIR/"* "$CONFIG_DIR/"

chmod +x "$CONFIG_DIR/rofi/powermenu.sh"
chmod +x "$CONFIG_DIR/polybar/launch.sh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
