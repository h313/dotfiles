#!/bin/bash

dunstctl close-all
dunstctl set-paused true

betterlockscreen --lock &
wait

dunstctl set-paused false
