#!/usr/bin/env bash

shopt -s extglob nullglob

# Set the directories to pick images from, separated by spaces
dirs=(
  /image/path1
  /image/path2
  /image/path3
)

# Set the image file extensions to look for
extensions=("jpg" "jpeg" "png")

# Set the time to change the wallpaper (in seconds)
time_interval=600

while true; do
  # Get the list of images with the specified extensions in the specified directories
  images=()
  for dir in "${dirs[@]}"; do
    for ext in "${extensions[@]}"; do
      images+=("$dir"/*."$ext")
    done
  done

  # Count the number of images
  n=${#images[@]}

  # Select a random image and loop
  if (( n > 0 )); then
    rand=$(( RANDOM % n ))
    wallpaper=${images[rand]}

    # Print the total image count and selected wallpaper with date and time
    printf '[%s] [Total image count: %d] Using image: %s\n' "$(date +'%Y-%m-%d %r UTC %Z')" "$n" "$wallpaper" | tee -a ~/wallpaper-rotator.log

    # Set the wallpaper
    pcmanfm --set-wallpaper="$wallpaper" --wallpaper-mode=crop
  fi

  # Wait before changing the wallpaper again
  sleep $time_interval
done
