#!/bin/bash

pkill -xu $EUID -USR1 dunst
betterlockscreen_rapid 5 pixel &
wait
pkill -xu $EUID -USR2 dunst
