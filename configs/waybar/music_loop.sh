#!/bin/bash

UPDATE_INTERVAL=5
WIDTH=17  

# Define the scrolling speed in seconds (lower is faster)
SCROLL_SPEED=0.20

# Initial media info
current_media_info=""
scrolling_pid=""

# Function to fetch current media info
get_media_info() {
    media_info=$(playerctl metadata --format "{{title}}")

    # If no media is playing, show a message
    if [[ -z "$media_info" ]]; then
        media_info="No media playing"
    fi
    echo "$media_info"
}

# Function to scroll the text smoothly to the RIGHT
scroll_text() {
    text="$1"


    text="${text%}"
    long_text="$text  $text"

    len=${#long_text}

    # Infinite loop to scroll text
    while true; do
        for ((i=$len-$WIDTH; i>=0; i--)); do
            echo "{\"text\": \"${long_text:$i:$WIDTH}\"}"
            sleep $SCROLL_SPEED 
        done
    done
}

# Function to start the scrolling and handle transitions
start_scrolling() {
    current_media_info=$(get_media_info)
    scroll_text "$current_media_info" &  
    scrolling_pid=$!  
}

# Function to update media info and scrolling together
update_media_and_scroll() {
    start_scrolling

    trap 'kill $scrolling_pid' EXIT

    while true; do
        new_media_info=$(get_media_info)
        
        if [[ "$new_media_info" != "$current_media_info" ]]; then
            current_media_info="$new_media_info"           
            kill $scrolling_pid

            # Start new scrolling loop with updated media info
            start_scrolling
        fi
        sleep $UPDATE_INTERVAL
    done
}

# Start the combined update and scroll function
update_media_and_scroll
