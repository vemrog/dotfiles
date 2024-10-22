#!/bin/bash

option0="stacked"
option1="tabbed"
option2="split"
option3="floating"
option4="fullscreen"

options="$option0\n$option1\n$option2\n$option3\n$option4"

selected="$(echo -e "$options" | rofi -lines 5 -dmenu -p "i3layout")"
case $selected in
    $option0)
        i3-msg layout stacked;;
    $option1)
        i3-msg layout tabbed;;
    $option2)
        i3-msg layout toggle split;;
    $option3)
        i3-msg floating toggle;;
    $option4)
        i3-msg fullscreen toggle;;
esac

