#!/bin/bash
# Defines the current script directory
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}";     )" &> /dev/null && pwd 2> /dev/null;     )";
SCRIPT_PARENT_DIR="${SCRIPT_DIR%/*}"

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

# Set shell
sudo chsh kasm-user -s /usr/bin/zsh

# Run configuration script(s)
$SCRIPT_DIR/../.config/firefox/configure-firefox.sh

# Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting

# Link ZSH config
ln -sf $SCRIPT_PARENT_DIR/.zshrc ~/.zshrc
