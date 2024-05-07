#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_video> <input_overlay_image>"
    exit 1
fi

# Assign input arguments to variables
input_video="$1"
input_overlay_image="$2"
output_video="output.mp4"

# Check if input video exists
if [ ! -f "$input_video" ]; then
    echo "Input video file does not exist"
    exit 1
fi

# Check if overlay image exists
if [ ! -f "$input_overlay_image" ]; then
    echo "Overlay image file does not exist"
    exit 1
fi

# Get dimensions of input video
video_width=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=s=x:p=0 "$input_video")
video_height=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=s=x:p=0 "$input_video")

# Run ffmpeg to resize overlay image to match video dimensions and overlay on video
ffmpeg -i "$input_overlay_image" -i "$input_video" -filter_complex "[0:v]scale=$video_width:$video_height [overlay]; [1:v][overlay]overlay=0:0" -codec:a copy "$output_video"

echo "Overlay applied successfully. Output saved as $output_video"

