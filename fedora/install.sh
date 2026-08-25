#!/bin/bash
# Defines the current script directory
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}";     )" &> /dev/null && pwd 2> /dev/null;     )";

# Set Wallpaper
IMAGE_FILE="/usr/share/backgrounds/bg_kasm.png"
SCREEN_PATH="/backdrop/screen0/monitorVNC-0/workspace0/last-image"
# Get screen path using 'xfconf-query -c xfce4-desktop -mv' and then change background
xfconf-query -c xfce4-desktop -p $SCREEN_PATH -s $IMAGE_FILE

# Install Apps
sudo dnf -y -q install firefox \
    neovim \
    bind-utils \
    iputils \
    flatpak

# Define any files that need to be linked
linkFiles=( \
    ".config/gtk-3.0/settings.ini"
)

# Define any directories that need to be linked
linkDirs=( \
    ".config/xfce4"
)

# Loop through the linkFiles list
for file in ${linkFiles[@]}; do
    # Delete the file if it exists
    rm ~/$file &> /dev/null
    
    # Check if the $file variable contains '/' to
    # determine if it goes into a subdirectory of ~
    if [[ "$file" == *"/"* ]]; then
        # Create the subdirectory if it doesn't exist
        mkdir -p ~/${file%/*}
    fi
    
    # Link the file
    ln -sf $SCRIPT_DIR/../$file ~/$file
done

# Loop through the linkDirs list
for dir in ${linkDirs[@]}; do
    # Delete the directory if it exists
    rm -rf ~/$dir

    # Link the directory
    ln -sfT $SCRIPT_DIR/../$dir ~/$dir
done

# Run configuration script(s)
$SCRIPT_DIR/../.config/firefox/configure-firefox.sh
