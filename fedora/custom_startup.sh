#!/usr/bin/env bash
# this file should live at /dockerstartup/custom_startup.sh
set -ex
/usr/bin/desktop_ready
mkdir -p ~/git
git clone https://github.com/Gvllvgher/kasm-scripts /home/kasm-user/git/kasm-scripts
/home/kasm-user/git/kasm-scripts/fedora/install.sh
