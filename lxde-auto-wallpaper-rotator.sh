#!/bin/bash

# Define the list of picture directories to use
PICTURE_DIRS=(/picture/path1 /picture/path2 /picture/path3)

# Define the time interval between wallpaper changes (in seconds)
INTERVAL=900

# Loop indefinitely to continuously change the wallpaper
while true; do

    # Choose a random picture from the specified directories
    PIC=$(find "${PICTURE_DIRS[@]}" -type f -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" | shuf -n 1)

    # Set the chosen picture as the desktop wallpaper
    pcmanfm --set-wallpaper="$PIC"

    # Wait for the specified interval before changing the wallpaper again
    sleep $INTERVAL

done
