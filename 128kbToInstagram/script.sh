#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "Error: ffmpeg is not installed. Please install ffmpeg and try again."
    exit 1
fi

# Check if input file is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 input.gif"
    exit 1
fi

# Input filename
input_file="$1"

# Check if input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file '$input_file' not found."
    exit 1
fi

# Output filename
output_file="${input_file%.gif}.mp4"

# Scale filter
scale_filter="scale=1080:-1:flags=neighbor"

# Temp file for the repeated input
temp_file="temp_input.mp4"

# Convert GIF to MP4 and loop
ffmpeg -i "$input_file" -vf "$scale_filter" -c:a copy "$temp_file"
for i in {1..3}; do echo "file '$temp_file'" >> temp_list.txt; done
ffmpeg -f concat -safe 0 -i temp_list.txt -c copy "$output_file"

# Clean up temp files
rm "$temp_file" temp_list.txt

echo "Conversion completed. MP4 file saved as: $output_file"

