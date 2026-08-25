#!/bin/bash
# Defines the current script directory
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}";     )" &> /dev/null && pwd 2> /dev/null;     )";

# Set Theme
THEME="Greybird-dark"
xfconf-query -c xsettings -p /Net/ThemeName -s $THEME
xfconf-query -c xfwm4 -p /general/theme -s $THEME
gsettings set org.gnome.desktop.interface gtk-theme $THEME

# Set Dark Mode
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Set Wallpaper
IMAGE_FILE="/usr/share/backgrounds/bg_kasm.png"
SCREEN_PATH="/backdrop/screen0/monitorVNC-0/workspace0/last-image"
# Get screen path using 'xfconf-query -c xfce4-desktop -mv' and then change background
xfconf-query -c xfce4-desktop -p $SCREEN_PATH -s $IMAGE_FILE

# Run configuration script(s)
$SCRIPT_DIR/../.config/firefox/configure-firefox.sh
