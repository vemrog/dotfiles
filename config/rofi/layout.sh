#!/bin/bash

# Current Theme
dir="$HOME/.config/rofi"
theme='layout'

# Options
tabbed='󰖯'
split='󰤼'
floating='󰖲'
fullscreen='󰊓'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "i3layout" \
		-theme ${dir}/${theme}.rasi
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$tabbed\n$split\n$floating\n$fullscreen" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ $1 == 'tabbed' ]]; then
		i3-msg layout tabbed
	elif [[ $1 == 'split' ]]; then
		i3-msg layout split
	elif [[ $1 == 'floating' ]]; then
		i3-msg floating toggle
	elif [[ $1 == 'fullscreen' ]]; then
		i3-msg fullscreen toggle
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $tabbed)
		run_cmd tabbed
        ;;
    $split)
		run_cmd split
        ;;
    $floating)
		run_cmd floating
        ;;
    $fullscreen)
		run_cmd fullscreen
        ;;
esac
