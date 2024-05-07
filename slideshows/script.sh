#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <input_images_folder> <audio_file> <frame_rate>"
    exit 1
fi

# Assign input arguments to variables
input_folder="$1"
audio_file="$2"
frame_rate="$3"

# Check if input folder exists
if [ ! -d "$input_folder" ]; then
    echo "Input folder does not exist"
    exit 1
fi

# Check if audio file exists
if [ ! -f "$audio_file" ]; then
    echo "Audio file does not exist"
    exit 1
fi

# Run ffmpeg to create slideshow
ffmpeg -framerate "$frame_rate" -i "$input_folder"/%d.png -i "$audio_file" -c:v libx264 -c:a aac -strict experimental -shortest output.mp4

echo "Slideshow created successfully as output.mp4"

