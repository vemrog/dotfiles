#!/bin/bash

option0="stacked"
option1="tabbed"
option2="split"

floating_state=$(i3-msg -t get_tree | jq '.. | select(.floating? == true)' | wc -l)

if [ "$floating_state" -gt 0 ]; then
    option3="floating (toggle off)"
else
    option3="floating (toggle on)"
fi

options="$option0\n$option1\n$option2\n$option3"

selected="$(echo -e "$options" | rofi -lines 4 -dmenu -p "i3layout")"
case $selected in
    $option0)
        i3-msg layout stacked;;
    $option1)
        i3-msg layout tabbed;;
    $option2)
        i3-msg layout toggle split;;
    $option3)
        i3-msg floating toggle;;
esac
