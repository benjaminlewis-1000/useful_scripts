#!/bin/bash
# Author: Serg Kolo
# Date: 2/18/2015
# Description: Open 4 terminals and position them


gnome-terminal -t WINDOW-ONE &
gnome-terminal -t WINDOW-TWO &
gnome-terminal -t WINDOW-THREE &
gnome-terminal -t WINDOW-FOUR &

sleep 0.5
wmctrl -r WINDOW-ONE -e 0,0,0,900,500 &
sleep 0.5
wmctrl -r WINDOW-TWO -e 0,0,540,900,500 &
sleep 0.5
wmctrl -r WINDOW-THREE -e 0,940,0,900,500 &
sleep 0.5
wmctrl -r WINDOW-FOUR -e 0,940,540,900,500 &
