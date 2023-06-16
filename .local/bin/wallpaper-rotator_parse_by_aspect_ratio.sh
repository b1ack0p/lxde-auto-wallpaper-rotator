#!/usr/bin/env bash

shopt -s extglob nullglob globstar

# Set the directories to pick images from
dirs=(
  /path/to/images/1
  /path/to/images/2
  /path/to/images/3
)

# Supported image file extensions to look for. (any image file extension supported by OS and Desktop Manager can be added)
extensions=("jpg" "jpeg" "png" "bmp" "svg")

# Set the minimum resolution limit (HEIGHT in pixels)
# Set to -1 to disable
min_resolution="1050"

# Select aspect ratio for the image to be set as wallpaper (e.g. "16:10", "16:9", "5:4", "4:3", "3:2", "1:1")
# Set the aspect ratio as a string in the form "WIDTH:HEIGHT" or leave it empty to disable
aspect_ratio="16:10"

# Set the time to change the wallpaper (in seconds)
time_interval="600"

# Define the path to the file containing the eligible images
eligible_images_file="$HOME/.local/bin/wallpaper-eligible-images.txt"

# Define log file path
log_file="$HOME/.local/bin/wallpaper-rotator.log"

# Define parser log file path
parser_log_file="$HOME/.local/bin/wallpaper-image-parser.log"

# Check if the file exists and load it if it does
if [[ -f "$eligible_images_file" ]]; then
  echo "Loading eligible images from file: $eligible_images_file"
  readarray -t images < "$eligible_images_file"
else
  # Get the list of images with the specified extensions in the specified directories (including subdirectories)
  images=()
  for dir in "${dirs[@]}"; do
    for ext in "${extensions[@]}"; do
      # Use 'identify' command from ImageMagick to get the resolution of the image
      for image in "$dir"/**/*."$ext"; do
        if [[ $min_resolution == -1 ]]; then
          images+=("$image")
        else
          resolution=$(identify -format '%wx%h' "$image")
          width=$(echo "$resolution" | cut -d 'x' -f 1)
          height=$(echo "$resolution" | cut -d 'x' -f 2)
          if (( height >= min_resolution )); then
            # Parse images also according to aspect ratio selection and add to eligible images list
            if [[ -z "$aspect_ratio" || $(bc -l <<< "$width/$height == ${aspect_ratio/:/\/}") -eq 1 ]]; then
              echo "[$(date +'%Y-%m-%d %r UTC %Z')]" "Image $image has resolution of ${width}x${height} pixels, meets the minimum height required ($min_resolution pixels), and matches the selected aspect ratio ($aspect_ratio), adding to the list!" | tee -a $parser_log_file
              images+=("$image")
            else
              echo "[$(date +'%Y-%m-%d %r UTC %Z')]" "Image $image has resolution of ${width}x${height} pixels, does not match the selected aspect ratio ($aspect_ratio), skipping..." | tee -a $parser_log_file
            fi
          else
            echo "[$(date +'%Y-%m-%d %r UTC %Z')]" "Image $image has resolution of ${width}x${height} pixels, does not meet the minimum height required ($min_resolution pixels), skipping..." | tee -a $parser_log_file
          fi
        fi
      done
    done
  done

  # Save the eligible images to file
  echo "Saving eligible images to file: $eligible_images_file"
  printf '%s\n' "${images[@]}" > "$eligible_images_file"
fi

while timeout 1 xwininfo -root -size >/dev/null 2>&1; do
  # Count the number of images
  n=${#images[@]}

  # Select a random image and loop
  if (( n > 0 )); then
    rand=$(( RANDOM % n ))
    wallpaper=${images[rand]}
    
    # Get the aspect ratio of the selected image by using 'identify' command from ImageMagick
    image_aspect=$(identify -format "%[fx:w/h]" "$wallpaper")

    # Print the total image count and selected wallpaper with date, time and resolution
    printf '[%s] [Total image count: %d] Using image as wallpaper: %s [Resolution: %s, Aspect Ratio: %s]\n' "$(date +'%Y-%m-%d %r UTC %Z')" "$n" "$wallpaper" "$(identify -format '%wx%h' "$wallpaper")" "$image_aspect" | tee -a "$log_file"

    # Set the wallpaper
    pcmanfm --set-wallpaper="$wallpaper" --wallpaper-mode=crop
  fi

  # Wait before changing the wallpaper again
  sleep $time_interval
done